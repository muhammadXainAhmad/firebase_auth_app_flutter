import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/Views/show_otp_dialog.dart';
import 'package:firebase_auth_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPhoneSignIn extends StatefulWidget {
  const MyPhoneSignIn({super.key});

  @override
  State<MyPhoneSignIn> createState() => _MyPhoneSignInState();
}

class _MyPhoneSignInState extends State<MyPhoneSignIn> {
  TextEditingController phoneController = TextEditingController();
  String? phoneNumber;
  Future<void> phoneSignIn(String phoneNumber) async {
    TextEditingController codeController = TextEditingController();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("data")));
      },
      codeSent: (verificationId, forceResendingToken) async {
        showOTPDialog(
          context: context,
          codeController: codeController,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await FirebaseAuth.instance.signInWithCredential(credential);
            Navigator.of(context).pop();
          },
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP Sign In.",
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixText: "+92",
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: MyConstants().eBorder,
                  focusedBorder: MyConstants().fBorder,
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
                  phoneSignIn("+92${phoneController.text.trim()}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "RECEIVE OTP",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
