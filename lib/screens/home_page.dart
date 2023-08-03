import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: Center(child: Text("LOGGED IN: ${user!.email}")),
    );
  }
}
