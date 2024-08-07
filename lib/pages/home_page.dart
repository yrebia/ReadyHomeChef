import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/SidebarDrawer.dart';
import 'package:ready_home_chef/components/makable_recipes_carrousel.dart';
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
        title: const Text(''), // Utilisez une chaîne vide pour supprimer le titre
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
        iconTheme: const IconThemeData(color: Color(0xFF2E2E2E)), // Définit la couleur des icônes
      ),

      drawer: const SidebarDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bannière d'utilisateur
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
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
              const SizedBox(height: 24),
      
              // Utilisation de l'alias pour le composant SearchBar
              mySearchBar.SearchBar(controller: TextEditingController()),
      
              const SizedBox(height: 24),
      
              // Recette du jour
              const Text(
                'Recipes of the day',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Carrousel de recettes populaires
              PopularRecipesCarousel(),
              const SizedBox(height: 32),

              const Text(
                'Recipes you can make',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Carrousel de recettes populaires
              MakableRecipesCarousel(),
              const SizedBox(height: 32),
      
              // My Favorites
              const Text(
                'My Favorites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
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
