import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/drink_full_data_array.dart';
import 'package:tchintchin/jsondart/full_data_drink.dart';

class Cocktail extends StatefulWidget {
  final String idDrink;

  const Cocktail({ Key? key, required this.idDrink }) : super(key: key);

  @override
  _CocktailState createState() => _CocktailState();
}

class _CocktailState extends State<Cocktail> {
  List<FullDataDrink>? _drinks = [];
  FullDataDrink? drink = new FullDataDrink();

  Future<void> _getDrinkFullData() async {
    log(widget.idDrink);
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + widget.idDrink
    );
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

  @override
  Widget build(BuildContext context) {
    _getDrinkFullData();
    return Container(
      child: Text(drink!.strDrink!),
    );
  }
}