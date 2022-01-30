import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class Database {
  DatabaseReference likesRef = FirebaseDatabase.instance.ref("likes");
  DatabaseReference commentsRef = FirebaseDatabase.instance.ref("comments");

  Future<DataSnapshot> getLikes() async {
    DatabaseEvent event = await likesRef.once();

    return event.snapshot;
  }

  Future<DataSnapshot> getComments() async {
    DatabaseEvent event = await commentsRef.once();

    return event.snapshot;
  }

  void updateLikes(List likes) {
    likesRef.set(likes);
  }

  void updateComments(List comments) {
    commentsRef.set(comments);
  }
}