import 'package:auth_practice/cloud_services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseApi.signOutUser();
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/user.json",
            height: 250,
            width: 250,
            fit: BoxFit.fill,
          ),
          Text(
            "LOGGED IN: ${user!.email}",
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
