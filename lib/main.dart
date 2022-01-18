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
        primarySwatch: Colors.red,
      ),
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
        appBar: AppBar(
            title: Text('Titre')
        ),
        body: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'ERREUR';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _passwordController
                ),
                ElevatedButton(onPressed: () async {
                  if (_key.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    var password = _passwordController.value.text;
                    var email = _emailController.value.text;
                    User? user = await _auth.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CocktailsList()));
                    }
                    else {
                      _auth.showErrorAlertDialog(
                          context,
                          "Identifiants incorrects",
                          "Vos identifiants sont incorrects, veuillez réessayer."
                      );
                    }
                  }

                }, child: Text('Valider'))
              ],
            )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CocktailsList()
            )
        );},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}