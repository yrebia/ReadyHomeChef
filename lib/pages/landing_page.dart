import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/landing_screens/page1.dart';
import 'package:ready_home_chef/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, bool> restriction = {
    'vegetarian': false,
    'pescatarian': false,
    'noDairy': false,
    'noPork': false,
    'vegan': false,
    'noGluten': false,
  };

  List<bool> list = [false, false, false, false, false, false];

  void savePreferences() async {
    try {
      await firestore.collection('user').doc(user?.uid).set(restriction);
      print('Document ajouté avec succès à la collection "users".');
    } catch (e) {
      print('Erreur lors de l\'ajout du document : $e');
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
        return HomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroPage1(
              list: restriction,
              nextPage:() {
                savePreferences();
              },
            ),
    );
  }
}