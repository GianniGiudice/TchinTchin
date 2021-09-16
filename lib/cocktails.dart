import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/cocktail.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  List<Cocktail> _cocktails = [];

  Future<void> _getAllCocktails() async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail");

    var responseFromApi = await http.get(uri);
    if (responseFromApi.statusCode == 200) {
      setState(() {
        Cocktail cocktails = Cocktail.fromJson(
            jsonDecode(responseFromApi.body));
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body:
          ListView.separated(
            separatorBuilder: (BuildContext context,
                int index) => const Divider(),
            itemCount: _cocktails.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_cocktails[index].strDrink ?? "VIDE"),
                leading: Image.network(_cocktails[index].strDrinkThumb ?? ""),
                /*onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CharacterScreen(character: _characters[index])
                    )
                );
              },*/
              );
            },
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
