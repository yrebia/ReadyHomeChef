import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroPage2 extends StatefulWidget {
  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  bool isVegetarian = false;
  bool isPescatarian = false;
  bool noDairy = false;
  bool noPork = false;
  bool isVegan = false;
  bool noGluten = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Preferences'),
      ),
      body: Center(child: Text("Aliments à ban"))
    );
  }
}
