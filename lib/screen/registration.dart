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
                Image.asset('assets/images/alcohol_yellow.png', height: 120),
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
                                      Flexible(child: Container(child:
                                      Text(
                                        'Vous pouvez vous connecter.',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xff1C8D5A),
                                            fontSize: 20),
                                      )))
                                    ],
                                  ))
                              : Text(''),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Text(
                              'Cr??er mon compte',
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
                                                  return 'Ce champ est requis';
                                                }
                                                // using regular expression
                                                if (!RegExp(r'\S+@\S+\.\S+')
                                                    .hasMatch(value!)) {
                                                  return "Veuillez entrer une adresse email valide";
                                                }
                                                return null;
                                              },
                                            )),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintStyle:
                                                TextStyle(color: Colors.white),
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
                                          controller: _passwordController,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return 'Ce champ est requis';
                                            }
                                            return null;
                                          },
                                        ),
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
                                                          "L'adresse mail est d??j?? utilis??e ou le mot de passe est incorrect. (il faut au moins 6 caract??res)");
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
