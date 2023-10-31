import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/img/background.jpg'), // Remplacez par le chemin de votre image de fond
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 90, 51, 21).withOpacity(0.0),
              Color.fromARGB(255, 78, 51, 36).withOpacity(0.8),
              Color.fromARGB(255, 137, 48, 4).withOpacity(0.15),
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do you have any dietary preferences?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  buildDietOption(
                    FontAwesomeIcons.apple,
                    'Vegetarian',
                    isVegetarian,
                    (value) {
                      setState(() {
                        isVegetarian = value;
                      });
                    },
                  ),
                  buildDietOption(
                    FontAwesomeIcons.fish,
                    'Pescatarian',
                    isPescatarian,
                    (value) {
                      setState(() {
                        isPescatarian = value;
                      });
                    },
                  ),
                  buildDietOption(
                    FontAwesomeIcons.cheese,
                    'No Dairy',
                    noDairy,
                    (value) {
                      setState(() {
                        noDairy = value;
                      });
                    },
                  ),
                  buildDietOption(
                    FontAwesomeIcons.bacon,
                    'No Pork',
                    noPork,
                    (value) {
                      setState(() {
                        noPork = value;
                      });
                    },
                  ),
                  buildDietOption(
                    FontAwesomeIcons.seedling,
                    'Vegan',
                    isVegan,
                    (value) {
                      setState(() {
                        isVegan = value;
                      });
                    },
                  ),
                  buildDietOption(
                    FontAwesomeIcons.breadSlice,
                    'No Gluten',
                    noGluten,
                    (value) {
                      setState(() {
                        noGluten = value;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  String preferences = '';
                  if (isVegetarian) {
                    preferences += 'Vegetarian ';
                  }
                  if (isPescatarian) {
                    preferences += 'Pescatarian ';
                  }
                  if (noDairy) {
                    preferences += 'No Dairy ';
                  }
                  if (noPork) {
                    preferences += 'No Pork ';
                  }
                  if (isVegan) {
                    preferences += 'Vegan ';
                  }
                  if (noGluten) {
                    preferences += 'No Gluten ';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected preferences: $preferences'),
                    ),
                  );
                },
                child: Text('Submit Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDietOption(
    IconData icon,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      width: 100,
      child: Column(
        children: [
          IconButton(
            icon: FaIcon(icon, size: 32),
            color: value ? Colors.green : Colors.grey,
            onPressed: () {
              onChanged(!value);
            },
          ),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
