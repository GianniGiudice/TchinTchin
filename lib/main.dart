import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tchintchin/cocktails_list.dart';
import 'package:tchintchin/service/authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tchin Tchin',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.indigo,
          primaryColor: Colors.white),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthenticationService _auth = AuthenticationService();
  GlobalKey<FormState> _key = GlobalKey();
  String error = '';
  bool loading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            Image.asset('images/alcohol.png', height: 120),
            Text('TchinTchin',
                style: TextStyle(
                    fontSize: 30,
                    color: const Color(0xff37718E),
                    fontWeight: FontWeight.bold)),
          ],
        )),
      )),
      Expanded(
          child: Container(
              color: const Color(0xff37718E),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                          key: _key,
                          child: Column(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
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
                                        controller: _passwordController),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(
                                                MediaQuery.of(context).size.width * 0.65, 50),
                                                primary:
                                                    const Color(0xfffafafa),
                                                onPrimary:
                                                    const Color(0xff37718E)
                                            ),
                                            onPressed: () async {
                                              if (_key.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  loading = true;
                                                });
                                                var password =
                                                    _passwordController
                                                        .value.text;
                                                var email =
                                                    _emailController.value.text;
                                                User? user = await _auth
                                                    .signInWithEmailAndPassword(
                                                        email, password);
                                                if (user != null) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CocktailsList()));
                                                } else {
                                                  _auth.showErrorAlertDialog(
                                                      context,
                                                      "Identifiants incorrects",
                                                      "Vos identifiants sont incorrects, veuillez réessayer.");
                                                }
                                              }
                                            },
                                            child: Text('Connexion')))
                                  ]))
                            ],
                          )),
                    ]),
              ))),
    ]), floatingActionButton: Container(
        height: 40,
        width: 200,
        child: FloatingActionButton(
          hoverElevation: 0,
          hoverColor: Color(0xff37718E),
          elevation: 0,
          backgroundColor: Color(0xff37718E),
          foregroundColor: Colors.white,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)), side: BorderSide(width: 0, color: Color(0xff37718E))),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CocktailsList()));
          },
          tooltip: 'Inscription',
          child: Column(
            children: [
              Icon(Icons.supervisor_account),
              const Text('Créer mon compte')
            ]
          ),
        )));
  }
}
