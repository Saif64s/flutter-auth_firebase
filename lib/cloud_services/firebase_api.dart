import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  static Future<void> registerUserWithEmailPassword(BuildContext context,
      String email, String password, String confirmPassword) async {
    try {
      if (password == confirmPassword) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided Doesnot match.")));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'user-not-found:') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account does not exist. Try creating one")));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginUserWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'user-not-found:') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account does not exist. Try creating one")));
      }
    }
  }
}
