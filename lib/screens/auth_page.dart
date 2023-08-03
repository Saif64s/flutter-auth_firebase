import 'package:auth_practice/screens/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if User is logged In
          if (snapshot.hasData) {
            return HomePage();
          }
          // IF USer is not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
