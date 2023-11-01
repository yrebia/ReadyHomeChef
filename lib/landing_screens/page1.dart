import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroPage1 extends StatefulWidget {

  List<bool> list;

  IntroPage1({
    super.key,
    required this.list,
  });

  @override
  _IntroPage1State createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Preferences'),
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('img/cat.jpg'), // Remplacez par le chemin de votre image de fond
          //   fit: BoxFit.cover,
          // ),
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
                    widget.list[0],
                    0,
                  ),
                  buildDietOption(
                    FontAwesomeIcons.fish,
                    'Pescatarian',
                    widget.list[1],
                    1,
                  ),
                  buildDietOption(
                    FontAwesomeIcons.cheese,
                    'No Dairy',
                    widget.list[2],
                    2,
                  ),
                  buildDietOption(
                    FontAwesomeIcons.bacon,
                    'No Pork',
                    widget.list[3],
                    3,
                  ),
                  buildDietOption(
                    FontAwesomeIcons.seedling,
                    'Vegan',
                    widget.list[4],
                    4,
                  ),
                  buildDietOption(
                    FontAwesomeIcons.breadSlice,
                    'No Gluten',
                    widget.list[5],
                    5,
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     String preferences = '';
              //     if (widget.isVegetarian) {
              //       preferences += 'Vegetarian ';
              //     }
              //     if (widget.isPescatarian) {
              //       preferences += 'Pescatarian ';
              //     }
              //     if (noDairy) {
              //       preferences += 'No Dairy ';
              //     }
              //     if (noPork) {
              //       preferences += 'No Pork ';
              //     }
              //     if (isVegan) {
              //       preferences += 'Vegan ';
              //     }
              //     if (noGluten) {
              //       preferences += 'No Gluten ';
              //     }
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(
              //         content: Text('Selected preferences: $preferences'),
              //       ),
              //     );
              //   },
              //   child: Text('Submit Preferences'),
              // ),
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
    int index,
  ) {
    return Container(
      width: 100,
      child: Column(
        children: [
          IconButton(
            icon: FaIcon(icon, size: 32),
            color: value ? Colors.green : Colors.grey,
            onPressed: () {
              setState(() {
                widget.list[index] = !widget.list[index];
              });
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
