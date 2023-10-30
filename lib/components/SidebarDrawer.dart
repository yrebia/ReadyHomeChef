import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 243, 149, 33), // Couleur d'arrière-plan de la sidebar
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "User Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              accountEmail: Text(
                "user@example.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.user,
                  size: 64,
                  color: Colors.orange,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // Couleur d'arrière-plan de l'en-tête
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.chartBar),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              onTap: () {
                // Naviguez vers la page du tableau de bord
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.search),
              title: Text(
                'Search Recipes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              onTap: () {
                // Naviguez vers la page de recherche de recettes
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.heart),
              title: Text(
                'Favorite Recipes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              onTap: () {
                // Naviguez vers la page des recettes favorites
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userCircle),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte
                ),
              ),
              onTap: () {
                // Naviguez vers la page de profil de l'utilisateur
              },
            ),
            // Bouton "Go Back" personnalisé
            ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: Colors.white, // Couleur de l'icône
              ),
              title: Text(
                'Retour à la page précédente',
                style: TextStyle(
                  color: Colors.white, // Couleur du texte
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Revenir à la page précédente
              },
            ),
          ],
        ),
      ),
    );
  }
}
