import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/recipe.dart';
import 'package:ready_home_chef/components/search_bar.dart' as mySearchBar;

class SearchRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
        backgroundColor: Colors.orange, // Couleur de la barre d'appel
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          mySearchBar.SearchBar(controller: TextEditingController()),
          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 16,
              children: [
                FilterChip(
                  label: Text('Filtre 1'),
                  onSelected: (selected) {
                    // Gérez la sélection du filtre
                  },
                  backgroundColor: Colors.orange, // Couleur du filtre
                  selected: false, // Personnalisez le statut sélectionné si nécessaire
                ),
                FilterChip(
                  label: Text('Filtre 2'),
                  onSelected: (selected) {
                    // Gérez la sélection du filtre
                  },
                  backgroundColor: Colors.orange, // Couleur du filtre
                  selected: false, // Personnalisez le statut sélectionné si nécessaire
                ),
                // Ajoutez d'autres filtres ici
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      searchResults[index].recipeName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(searchResults[index].description),
                    leading: Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          searchResults[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Gérez ce qui se passe lorsque l'utilisateur clique sur une recette
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
