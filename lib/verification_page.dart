import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyVerificationPage extends StatefulWidget {
  const MyVerificationPage({super.key});

  @override
  State<MyVerificationPage> createState() => _MyVerificationPageState();
}

class _MyVerificationPageState extends State<MyVerificationPage> {
  Future<void> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Email verfication sent!",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? "An unexpected error occurred",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> reloadVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  void initState() {
    sendVerificationEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => reloadVerification(),
        child: Icon(Icons.replay_rounded),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Open your mail & click on the link to verify your email. Then, reload this page by clicking on the button below.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
