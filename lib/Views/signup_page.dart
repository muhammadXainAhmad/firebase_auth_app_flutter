import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/Utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      if (kDebugMode) {
        print(userCredential);
      }
      if (mounted) {
        showSnack(context, "Account successfully created!", Colors.green);
        Navigator.of(context).pushReplacementNamed("verification");
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      if (mounted) {
        showSnack(context, "Incorrect email or password!", Colors.red);
      }
    }
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: MyConstants.eBorder,
                  focusedBorder: MyConstants.fBorder,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: MyConstants.eBorder,
                  focusedBorder: MyConstants.fBorder,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await createUserWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("SIGN UP", style: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Text(
                "Already have an account?",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
