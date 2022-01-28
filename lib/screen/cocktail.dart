import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/drink_full_data_array.dart';
import 'package:tchintchin/jsondart/full_data_drink.dart';
import 'package:tchintchin/widget/mini_list_item.dart';
import 'package:firebase_database/firebase_database.dart';

class Cocktail extends StatefulWidget {
  final String? idDrink;

  const Cocktail({Key? key, required String? this.idDrink}) : super(key: key);

  @override
  _CocktailState createState() => _CocktailState();
}

class _CocktailState extends State<Cocktail> {
  List<FullDataDrink>? _drinks = [];
  FullDataDrink? drink;
  List? likes;

  Future<void> _getDrinkFullData() async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" +
            widget.idDrink!);
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      setState(() {
        DrinkFullDataArray list =
            DrinkFullDataArray.fromJson(jsonDecode(responseFromApi.body));
        _drinks = list.drinks!;
        drink = _drinks?[0];
      });
    }
  }

  void _getCurrentLikes() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('likes');
    DatabaseEvent event = await ref.once();
    likes = jsonDecode(jsonEncode(event.snapshot.value));
  }

  @override
  Widget build(BuildContext context) {
    _getDrinkFullData();
    _getCurrentLikes();
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(drink!.strDrinkThumb!),
                      fit: BoxFit.cover)))),
      Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.all(30),
                  color: const Color(0xfffafafa),
                  child: Column(children: [
                    Text(drink!.strDrink!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Wrap(children: [
                          for (var i = 0; i < 15; i++) MiniListItem(text: drink!.strIngredients![i])
                        ]))
                  ]))))
    ]));
  }
}
