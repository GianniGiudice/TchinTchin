import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/categories_l.dart';
import 'package:tchintchin/jsondart/category.dart';
import 'package:tchintchin/screen/drinks_by_category.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getAllCategories();

    return Scaffold(
        appBar: AppBar(
          title: Text('Liste des catégories',
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
                    itemCount: _categories?.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: Text(
                                          _categories?[index].strCategory ??
                                              "VIDE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DrinksByCategory(
                                                        category: _categories![
                                                                index]
                                                            .strCategory!)));
                                      },
                                    )
                                  ])));
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(1, 1);
                    },
                  )))
        ]));
  }
}
