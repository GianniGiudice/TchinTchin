import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/categories_l.dart';
import 'package:tchintchin/jsondart/category.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<Category>? _categories = [];

  Future<void> _getAllCategories() async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");

    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      setState(() {
        CategoriesL list =
            CategoriesL.fromJson(jsonDecode(responseFromApi.body));
        _categories = list.drinks!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAllCategories();
    return Scaffold(
        body: Column(children: [
      Container(
          margin: const EdgeInsets.all(15),
          child: Text('Liste des catégories',
              style: TextStyle(
                  fontSize: 30,
                  color: const Color(0xff37718E),
                  fontWeight: FontWeight.bold))),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(30),
              child: ListView.builder(
                itemCount: _categories?.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(
                                _categories?[index].strCategory ?? "VIDE",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            /*onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CharacterScreen(
                                      character: _characters[index])));
                            },*/
                          )));
                },
              )))
    ]));
  }
}
