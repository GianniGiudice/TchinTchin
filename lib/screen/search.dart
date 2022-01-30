import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:tchintchin/jsondart/drink_full_data_array.dart';
import 'package:tchintchin/jsondart/full_data_drink.dart';
import 'package:tchintchin/screen/cocktail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  List<FullDataDrink>? _drinks;

  Future<void> _getDrinksByFilter(String filter) async {
    var uri = Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=" + filter);
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      setState(() {
        DrinkFullDataArray list =
            DrinkFullDataArray.fromJson(jsonDecode(responseFromApi.body));
        _drinks = list.drinks!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Recherche',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              )),
          centerTitle: true,
          backgroundColor: const Color(0xff37718E),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              labelText: 'Recherche',
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: const Color(0xff37718E))),
                              hintStyle: TextStyle(
                                  color: const Color(0xff37718E),
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                              labelStyle:
                                  TextStyle(color: const Color(0xff37718E)))))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.65, 50),
                              primary: const Color(0xff37718E),
                              onPrimary: const Color(0xffffffff)),
                          child: Text('Valider'),
                          onPressed: () async {
                            var search = _searchController.value.text;
                            _getDrinksByFilter(search);
                          }))),
              Container(
                  child: Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(30),
                          child: _drinks == null
                              ? Text('')
                              : StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  itemCount: _drinks?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Cocktail(
                                                          idDrink: _drinks![
                                                                  index]
                                                              .idDrink!
                                                              .toString())));
                                        },
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        _drinks?[index]
                                                                .strDrinkThumb ??
                                                            ""))),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                  child: Text(
                                                      _drinks?[index]
                                                              .strDrink ??
                                                          "VIDE",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center)),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 10.0),
                                        ));
                                  },
                                  staggeredTileBuilder: (int index) {
                                    return StaggeredTile.count(1, 1);
                                  },
                                ))))
            ])));
  }
}
