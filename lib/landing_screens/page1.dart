import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ready_home_chef/components/my_button.dart';

class IntroPage1 extends StatefulWidget {
  final Map<String, bool> list;
  final Function() nextPage;

  IntroPage1({
    super.key,
    required this.list,
    required this.nextPage,
  });

  @override
  _IntroPage1State createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {

  void submit() {
    widget.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Preferences'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 140, 0), Color.fromARGB(255, 246, 197, 137)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'What are your dietary preferences?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 60),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                buildDietOption(
                  FontAwesomeIcons.apple,
                  'Vegetarian',
                  widget.list["vegetarian"]!,
                  "vegetarian",
                ),
                buildDietOption(
                  FontAwesomeIcons.fish,
                  'Pescatarian',
                  widget.list["pescatarian"]!,
                  "pescatarian",
                ),
                buildDietOption(
                  FontAwesomeIcons.cheese,
                  'No Dairy',
                  widget.list["noDairy"]!,
                  "noDairy",
                ),
                buildDietOption(
                  FontAwesomeIcons.bacon,
                  'No Pork',
                  widget.list["noPork"]!,
                  "noPork",
                ),
                buildDietOption(
                  FontAwesomeIcons.seedling,
                  'Vegan',
                  widget.list["vegan"]!,
                  "vegan",
                ),
                buildDietOption(
                  FontAwesomeIcons.breadSlice,
                  'No Gluten',
                  widget.list["noGluten"]!,
                  "noGluten",
                ),
              ],
            ),
            SizedBox(height: 40),
                                MyButton(
                      onTap: submit,
                      text: 'Next',
                    ),
          ],
        ),
      ),
    );
  }

  Widget buildDietOption(
    IconData icon,
    String label,
    bool value,
    String index,
  ) {
    return Column(
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: FaIcon(
              icon,
              size: 48,
              color: value ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                widget.list[index] = !widget.list[index]!;
              });
            },
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
