import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  bool hasLiked = false;
  DatabaseReference ref = FirebaseDatabase.instance.ref('likes');

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

  void _searchForUserId() {
    if (likes!.indexWhere((element) => (element['user_id'] == user!.uid && element['cocktail_id'] == widget.idDrink!)) != -1) {
      setState(() {
        hasLiked = true;
      });
    }
  }

  void _getCurrentLikes() async {
    DatabaseEvent event = await ref.once();
    likes = jsonDecode(jsonEncode(event.snapshot.value));
  }

  void addLike() {
    // Si on on ne trouve pas, alors on peut ajouter le like
    if (likes!.indexWhere((element) => (element['user_id'] == user!.uid && element['cocktail_id'] == widget.idDrink!)) == -1) {
      log(user!.uid.toString());
      likes!.add({"user_id": user!.uid, "cocktail_id": widget.idDrink!});
    }
  }

  Map<String, dynamic> toJson(item) => {'user_id': item['user_id'], 'cocktail_id': item['cocktail_id']};

  void updateLikeUserStatus() {
    if (!hasLiked) {
      addLike();
    }
    else {
      likes!.removeWhere((element) => (element['user_id'] == user!.uid && element['cocktail_id'] == widget.idDrink!));
    }
    List result = [];
    likes!.forEach((item) {
      result.add(toJson(item));
    });
    ref.set(result);
  }

  @override
  Widget build(BuildContext context) {
    _getDrinkFullData();
    _getCurrentLikes();
    _searchForUserId();
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(drink!.strDrinkThumb!),
                    fit: BoxFit.cover))),
        Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () {
                  updateLikeUserStatus();
                  setState(() {
                    hasLiked = !hasLiked;
                  });
                },
                child: Icon(Icons.favorite,
                    color: hasLiked ? Colors.red : Colors.black, size: 40)))
      ])),
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
                          for (var i = 0; i < 15; i++)
                            MiniListItem(text: drink!.strIngredients![i])
                        ]))
                  ]))))
    ]));
  }
}
