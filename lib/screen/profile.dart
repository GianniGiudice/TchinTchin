import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Column(children: [
        Text('Bienvenue ' + (user != null ? user!.email! : 'dommage'))
      ]),
    );
  }

}