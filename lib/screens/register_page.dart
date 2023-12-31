import 'package:auth_practice/cloud_services/firebase_api.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/my_buttons.dart';
import '../widgets/my_txtfld.dart';
import '../widgets/square_tile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  late AnimationController _animationController;
  bool isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  // sign user up method
  void registerUser() async {
    setState(() {
      isAuthenticating = true;
      _animationController.forward();
    });

    FirebaseApi.registerUserWithEmailPassword(context, _emailController.text,
        _passwordController.text, _confirmedPasswordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo

                Lottie.asset("assets/sign_up_animation.json",
                    controller: _animationController,
                    height: 220,
                    width: 220,
                    fit: BoxFit.fill),

                // welcome back, you've been missed!
                Text(
                  'Lets Create an Account. Shall we?',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15),

                // username textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email or Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: _confirmedPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                // sign in button
                if (isAuthenticating) const CircularProgressIndicator(),
                if (!isAuthenticating)
                  MyButton(
                    onTap: registerUser,
                    text: 'Create an account',
                  ),

                const SizedBox(height: 30),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'assets/google.png',
                      onTap: () => FirebaseApi.signInWithGoogle(),
                    ),

                    const SizedBox(width: 25),

                    // apple button
                    SquareTile(
                      imagePath: 'assets/apple.png',
                      onTap: () {},
                    )
                  ],
                ),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login instead',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
