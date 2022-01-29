import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/cocktails.dart';
import 'package:tchintchin/jsondart/drink.dart';
import 'package:tchintchin/screen/cocktail.dart';

class DrinksByCategory extends StatefulWidget {
  final String? category;

  const DrinksByCategory({Key? key, required String? this.category})
      : super(key: key);

  @override
  _DrinksByCategoryState createState() => _DrinksByCategoryState();
}

class _DrinksByCategoryState extends State<DrinksByCategory> {
  List<Drink>? _drinks = [];

  Future<void> _getCategoryDrinks() async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=" +
            widget.category!);
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      setState(() {
        Cocktails list = Cocktails.fromJson(jsonDecode(responseFromApi.body));
        _drinks = list.drinks!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getCategoryDrinks();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(widget.category!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              )),
          centerTitle: true,
          backgroundColor: const Color(0xff37718E),
        ),
        body: Column(children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: _drinks?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Cocktail(
                                    idDrink:
                                        _drinks![index].idDrink!.toString())));
                          },
                          child: Card(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ListTile(
                                            title: Text(
                                                _drinks?[index].strDrink ??
                                                    "VIDE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        AspectRatio(
                                          child: Image.network(
                                              _drinks?[index].strDrinkThumb ??
                                                  "",
                                              fit: BoxFit.cover),
                                          aspectRatio: 2 / 1.5,
                                        )
                                      ]))));
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(1, 1);
                    },
                  )))
        ]));
  }
}
