import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_app/screens/discover.dart';
import 'package:practice_app/user.dart';

mixin FirebaseAuthService {
  final auth = FirebaseAuth.instance;
  String userId = '';

  signUp(email, password, context) async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, DiscoverScreen.routeName);
      }
    });
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userId = credentials.user?.uid as String;
    } catch (e) {
      print(e);
    }
  }

  signIn(email, password, context) async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, DiscoverScreen.routeName);
      }
    });
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      userId = credentials.user?.uid as String;
    } catch (e) {
      print(e);
    }
  }

  signOut(context) async {
    await auth.signOut();
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        userId = '';
        resetCurrentUser();
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
    });
  }
}
