import 'package:firebase_auth_app/firebase_methods.dart';
import 'package:flutter/material.dart';

class MyVerificationPage extends StatefulWidget {
  const MyVerificationPage({super.key});

  @override
  State<MyVerificationPage> createState() => _MyVerificationPageState();
}

class _MyVerificationPageState extends State<MyVerificationPage> {
  @override
  void initState() {
    FirebaseMethods().sendVerificationEmail(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseMethods().reloadVerification(context);
        },
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
