import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/cocktails.dart';
import 'package:tchintchin/jsondart/drink.dart';

class CocktailsList extends StatefulWidget {
  const CocktailsList({Key? key}) : super(key: key);

  @override
  _CocktailsListState createState() => _CocktailsListState();
}

class _CocktailsListState extends State<CocktailsList> {
  List<Drink> _drinks = [];

  Future<void> _getAllCocktails() async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    );

    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      setState(() {
        Cocktails cocktails =
            Cocktails.fromJson(jsonDecode(responseFromApi.body));
        _drinks = cocktails.drinks!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAllCocktails();
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            child: ListView.builder(
              itemCount: _drinks.length,
              itemBuilder: (context, index) {
                return Card(
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Text(_drinks[index].strDrink ?? "VIDE",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          leading: Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    _drinks[index].strDrinkThumb ?? "",
                                  ))),
                          /*onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CharacterScreen(character: _characters[index])
                    )
                );
              },*/
                        )));
              },
            )));
  }
}
