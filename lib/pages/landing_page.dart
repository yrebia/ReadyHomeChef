import 'package:flutter/material.dart';
import 'package:ready_home_chef/landing_screens/page1.dart';
import 'package:ready_home_chef/landing_screens/page2.dart';
import 'package:ready_home_chef/pages/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController _controller = PageController();

  bool onLastPage = false;

  // Page 1
  List<bool> list = [false, false, false, false, false, false];

  // bool isVegetarian = false;
  // bool isPescatarian = false;
  // bool noDairy = false;
  // bool noPork = false;
  // bool isVegan = false;
  // bool noGluten = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 1);
              });
            } ,
            children: [
              IntroPage1(
                list: list,
              ),
              IntroPage2(),
            ],
          ),

          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 32),
                  color: Colors.blue,
                  onPressed: () {
                    _controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),

                SmoothPageIndicator(controller: _controller, count: 2),

                onLastPage ? 
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.check, size: 32),
                  color: Colors.blue,
                  onPressed: () {
                    // envoyer les données
                    // Navigate to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                        return HomePage();
                        },
                      ),
                    );
                  },
                ) : 
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowRight, size: 32),
                  color: Colors.blue,
                  onPressed: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}