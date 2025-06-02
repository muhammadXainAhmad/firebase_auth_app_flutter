import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final _auth = FirebaseAuth.instance;

  // GOOGLE SIGN IN
  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(context, e.message!, Colors.red);
      }
    }
  }

  // VERIFICATION EMAIL
  Future<void> sendVerificationEmail(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      if (context.mounted) {
        showSnack(context, "Email verfication sent!", Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(
          context,
          e.message ?? "An unexpected error occurred",
          Colors.red,
        );
      }
    }
  }

  Future<void> reloadVerification(BuildContext context) async {
    try {
      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      if (user != null && user.emailVerified) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed("login");
        }
      } else {
        if (context.mounted) {
          showSnack(context, "Email not verified yet.", Colors.red);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(context, "Failed to check verification status.", Colors.red);
      }
    }
  }
}
