import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tchintchin/main.dart';
import 'package:tchintchin/service/authentication.dart';

import 'homepage.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthenticationService _auth = AuthenticationService();
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool registered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Expanded(
              child: Container(
            color: const Color(0xfffafafa),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/alcohol_yellow.png', height: 120),
                Text('TchinTchin',
                    style: TextStyle(
                        fontSize: 30,
                        color: const Color(0xffE0B850),
                        fontWeight: FontWeight.bold)),
              ],
            )),
          )),
          Expanded(
              child: Container(
                  color: const Color(0xffE0B850),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          registered
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.supervisor_account,
                                        color: Color(0xff1C8D5A),
                                      ),
                                      Text(
                                        'Vous êtes bien enregistré, vous pouvez dès à présent vous connecter.',
                                        style: TextStyle(
                                            color: Color(0xff1C8D5A),
                                            fontSize: 20),
                                      )
                                    ],
                                  ))
                              : Text(''),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Text(
                              'Créer mon compte',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          Form(
                              key: _key,
                              child: Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Column(children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                                  labelText: 'Adresse mail'),
                                              controller: _emailController,
                                              validator: (value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return 'ERREUR';
                                                }
                                                return null;
                                              },
                                            )),
                                        TextFormField(
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              fillColor: Colors.white,
                                              focusColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              labelText: 'Mot de passe',
                                            ),
                                            controller: _passwordController),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                        50),
                                                    primary:
                                                        const Color(0xfffafafa),
                                                    onPrimary: const Color(
                                                        0xffE0B850)),
                                                onPressed: () async {
                                                  if (_key.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    var password =
                                                        _passwordController
                                                            .value.text;
                                                    var email = _emailController
                                                        .value.text;
                                                    User? user = await _auth
                                                        .registerWithEmailAndPassword(
                                                            email, password);
                                                    if (user != null) {
                                                      setState(() {
                                                        registered = true;
                                                      });
                                                    } else {
                                                      _auth.showErrorAlertDialog(
                                                          context,
                                                          "Inscription impossible",
                                                          "L'adresse mail est déjà utilisée ou le mot de passe est incorrect. (il faut au moins 6 caractères)");
                                                    }
                                                  }
                                                },
                                                child: Text('Inscription')))
                                      ]))
                                ],
                              )),
                        ]),
                  ))),
        ]),
        floatingActionButton: Container(
            height: 40,
            width: 200,
            child: FloatingActionButton(
              hoverElevation: 0,
              hoverColor: Colors.transparent,
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(width: 0, color: Colors.transparent)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'TchinTchin')));
              },
              tooltip: 'Inscription',
              child: Column(children: [
                Icon(Icons.supervisor_account),
                const Text('Me connecter')
              ]),
            )));
  }
}
