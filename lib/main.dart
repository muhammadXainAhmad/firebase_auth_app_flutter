import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/phone_login_page.dart';
import 'package:firebase_auth_app/firebase_options.dart';
import 'package:firebase_auth_app/forgot_page.dart';
import 'package:firebase_auth_app/home_page.dart';
import 'package:firebase_auth_app/login_page.dart';
import 'package:firebase_auth_app/signup_page.dart';
import 'package:firebase_auth_app/verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        "login": (context) => const MyLoginPage(),
        "signup": (context) => const MySignUpPage(),
        "forgot": (context) => const MyForgotPage(),
        "home": (context) => const MyHomePage(),
        "verification": (context) => const MyVerificationPage(),
        "phone": (context) => const MyPhoneSignIn(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (kDebugMode) {
            print("AuthStateChanges snapshot: ${snapshot.data}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          final user = snapshot.data;

          if (user != null) {
            final provider =
                user.providerData.isNotEmpty
                    ? user.providerData[0].providerId
                    : null;

            if (provider == 'password') {
              return user.emailVerified
                  ? const MyHomePage()
                  : const MyVerificationPage();
            } else if (provider == 'phone') {
              return const MyHomePage();
            } else {
              return const MyHomePage();
            }
          } else {
            return const MyLoginPage();
          }
        },
      ),
    );
  }
}
