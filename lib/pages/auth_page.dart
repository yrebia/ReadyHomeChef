import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/pages/start_page.dart';

import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return StartPage();
          }
          // user is not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}