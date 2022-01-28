import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/drink_full_data_array.dart';
import 'package:tchintchin/jsondart/full_data_drink.dart';
import 'package:tchintchin/widget/mini_list_item.dart';

class Cocktail extends StatefulWidget {
  final String? idDrink;

  const Cocktail({Key? key, required String? this.idDrink}) : super(key: key);

  @override
  _CocktailState createState() => _CocktailState();
}

class _CocktailState extends State<Cocktail> {
  List<FullDataDrink>? _drinks = [];
  FullDataDrink? drink;

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

  @override
  Widget build(BuildContext context) {
    _getDrinkFullData();
    return Scaffold(body: _cocktail());
  }

  Widget _cocktail() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            foregroundColor: Colors.black,
            expandedHeight: MediaQuery.of(context).size.height / 2,
            backgroundColor: Colors.transparent,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                //titlePadding: EdgeInsetsDirectional.all(0),
                title: Text(
                  drink!.strDrink!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                background: Image.network(
                  drink!.strDrinkThumb!,
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Wrap(children: [
            for (var i = 0; i < 15; i++)
              MiniListItem(text: drink!.strIngredients![i])
          ])),
    );
  }
}
