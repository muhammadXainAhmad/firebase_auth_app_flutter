import 'package:firebase_auth_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Enter OTP", textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                child: TextField(
                  controller: codeController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: MyConstants().eBorder,
                    focusedBorder: MyConstants().fBorder,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text("Done", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
  );
}
