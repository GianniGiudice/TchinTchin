import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tchintchin/screen/homepage.dart';
import 'package:tchintchin/service/database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth? auth;
  User? user;
  File? imageFile;
  Database dbService = new Database();
  int likesCount = 0;
  int commentsCount = 0;

  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
    getUserDataInfo();
  }

  void getUserLikes() async {
    DataSnapshot snapshotLikes = await dbService.getLikes();
    List likes = jsonDecode(jsonEncode(snapshotLikes.value));

    likes.forEach((element) {
      if (element['user_id'] == user!.uid) {
        setState(() {
          likesCount++;
        });
      }
    });
  }

  void getUserComments() async {
    DataSnapshot snapshotComments = await dbService.getComments();
    List comments = jsonDecode(jsonEncode(snapshotComments.value));

    comments.forEach((element) {
      if (element['user'] == user!.email) {
        setState(() {
          commentsCount++;
        });
      }
    });
  }

  void getUserDataInfo() {
    getUserLikes();
    getUserComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profil',
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
              /*Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Stack(children: [
                    Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                          user!.photoURL != null
                              ? user!.photoURL!
                              : 'images/no-avatar.png',
                          height: 75,
                          width: 75),
                    )),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 23),
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: const Color(0xff37718E)),
                            )))
                  ]),
                  onTap: () async {
                        PickedFile pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
                        setState(() {
                          user!.updatePhotoURL(photoURL);
                          imageFile = File(pickedFile.path);
                        });
                  },)),*/
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        Text(
                          'Bienvenue ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text((user != null ? user!.email! : ''),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ]))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        Icon(Icons.info, color: Colors.black, size: 18),
                        Text(
                          ' ID utilisateur : ' +
                              (user != null ? user!.uid : ''),
                          style: TextStyle(fontSize: 18),
                        )
                      ]))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        Icon(Icons.favorite, color: Colors.red, size: 18),
                        Text(
                          ' Nombre de cocktails aimés : ' +
                              likesCount.toString(),
                          style: TextStyle(fontSize: 18),
                        )
                      ]))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        Icon(Icons.comment,
                            color: const Color(0xff37718E), size: 18),
                        Text(
                          ' Nombre de commentaires postés : ' +
                              commentsCount.toString(),
                          style: TextStyle(fontSize: 18),
                        )
                      ]))),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.65, 50),
                          primary: const Color(0xffCC4B29),
                          onPrimary: const Color(0xffffffff)),
                      child: Text('Déconnexion'),
                      onPressed: () async {
                        auth != null ? await auth!.signOut() : null;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: 'Tchin Tchin')));
                      }))
            ])));
  }
}
