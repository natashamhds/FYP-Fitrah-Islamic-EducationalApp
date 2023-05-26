// to see if we're logged in or not
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Login/login_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return const MainPage();
        } else {
          // user is NOT logged in
          return const LoginPage();
        }
      },
      )
    );
  }
}