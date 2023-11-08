import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/pages/landing_page.dart';

import 'home_page.dart';

class StartPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('user').doc(user?.uid).snapshots(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print('Has Data: ${snapshot.hasData} uid: ${user?.uid}');
            if (snapshot.hasData) {
              // L'utilisateur existe dans la base de données, vous pouvez continuer vers la page principale.
              // return FoodSearchPage();
              return HomePage();
            } else {
              // L'utilisateur n'existe pas dans la base de données, affichez la landing page.
              return LandingPage();
            }
          } else {
            // Affichez une indication de chargement si nécessaire.
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}