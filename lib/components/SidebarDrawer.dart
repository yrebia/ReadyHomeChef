import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ready_home_chef/pages/grocerylist_page.dart';
import 'package:ready_home_chef/pages/search_page.dart';
import 'package:ready_home_chef/pages/fridge_page.dart';



class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFF646464); // Couleur de la police plus douce

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 211, 164),
              Color.fromARGB(255, 226, 189, 149),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: textColor, // Utilisation de la couleur de la police
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.chartBar, color: textColor),
              title: Text(
                'Homepage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Verdana', // Changer la police ici
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Naviguez vers la page du tableau de bord
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.search, color: textColor),
              title: Text(
                'Search Recipes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Verdana',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchRecipePage()),
                  );}
            ),
            // ListTile(
            //   leading: Icon(FontAwesomeIcons.heart, color: textColor),
            //   title: Text(
            //     'Favorite Recipes',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: textColor,
            //       fontFamily: 'Verdana',
            //     ),
            //   ),
            //   onTap: () {
            //     // Naviguez vers la page des recettes favorites
            //   },
            // ),
            // ListTile(
            //   leading: Icon(FontAwesomeIcons.userCircle, color: textColor),
            //   title: Text(
            //     'Profile',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: textColor,
            //       fontFamily: 'Verdana',
            //     ),
            //   ),
            //   onTap: () {
            //     // Naviguez vers la page de profil de l'utilisateur
            //   },
            // ),
            Divider(
              color: textColor,
              height: 1,
              thickness: 1,
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.orange,
              child: SizedBox(
                width: 100,
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.snowflake),
                  title: Text(
                    'Your Fridge',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: 'Verdana',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FridgePage()),
                  );
                  },
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.orange,
              child: SizedBox(
                width: 150,
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.shoppingBasket),
                  title: Text(
                    'Your Grocery List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: 'Verdana',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroceryListPage()),
                  );
                  },
                ),
              ),
            ),
            Divider(
              color: textColor,
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt, color: textColor),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Verdana',
                ),
              ),
              onTap: () {
                // Gérez la déconnexion ici
              },
            ),
          ],
        ),
      ),
    );
  }
}
