import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/SidebarDrawer.dart';
import 'package:ready_home_chef/components/search_bar.dart' as mySearchBar;
import 'package:ready_home_chef/components/popular_recipes_carrousel.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.transparent, // Définit l'arrière-plan comme transparent
  elevation: 0, // Supprime l'ombre sous la barre d'applications
  title: Text(''), // Utilisez une chaîne vide pour supprimer le titre
  actions: [
    IconButton(
      onPressed: signUserOut,
      icon: Icon(Icons.logout),
    )
  ],
  iconTheme: IconThemeData(color: Color(0xFF2E2E2E)), // Définit la couleur des icônes
),

      drawer: SidebarDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bannière d'utilisateur
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore personalized recipes just for you.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
      
              // Utilisation de l'alias pour le composant SearchBar
              mySearchBar.SearchBar(controller: TextEditingController()),
      
              SizedBox(height: 24),
      
              // Recette du jour
              Text(
                'Recette du Jour',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Carrousel de recettes populaires
              PopularRecipesCarousel(),
              SizedBox(height: 32),
      
              // My Favorites
              Text(
                'My Favorites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'You don\'t have any recipes in favorites yet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
