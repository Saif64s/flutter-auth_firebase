import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  // Register user with email and password
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

  // Login user with Email and password
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

  // Google Sign In
  static signInWithGoogle() async {
    // begin sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
      return;
    }

    // obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // finally signing in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static void signOutUser() {
    FirebaseAuth.instance.signOut();
  }
}
