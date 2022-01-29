import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tchintchin/screen/homepage.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth? auth;
  User? user;

  void init() async {
    auth = FirebaseAuth.instance;
    setState(() {
      user = auth!.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Bienvenue ' +
                            (user != null ? user!.email! : '') +
                            ' !',
                        textAlign: TextAlign.left,
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text('ID utilisateur : ' +
                          (user != null ? user!.uid : '')))),
              Container(
                margin: EdgeInsets.only(top: 10),
                child:
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.65, 50),
                      primary: const Color(0xffCC4B29),
                      onPrimary: const Color(0xffffffff)),
                  child: Text('Déconnexion'),
                  onPressed: () async {
                    auth != null ? await auth!.signOut() : null;
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: 'Tchin Tchin')));
                  }))
            ])));
  }
}
