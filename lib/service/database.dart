import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class Database {
  DatabaseReference likesRef = FirebaseDatabase.instance.ref("likes");

  Future<DataSnapshot> getLikes() async {
    DatabaseEvent event = await likesRef.once();

    return event.snapshot;
  }

  void updateLikes(List likes) {
    likesRef.set(likes);
  }
}