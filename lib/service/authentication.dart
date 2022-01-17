import 'package:firebase_auth/firebase_auth.dart';
import 'package:tchintchin/model/AppUser.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebase(user);
    } catch (exception) {
      print(exception.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebase(user);
    } catch (exception) {
      print(exception.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
    }
  }
}