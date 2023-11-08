import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/search_bar.dart' as mySearchBar;
import 'package:ready_home_chef/pages/recipes_page.dart';

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

          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.requireData.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.requireData.docs[index];
                    Map item = document.data() as Map;
                    
                    return Card(
                      child: ListTile(
                        title: Text(item['title']),
                        subtitle: Image.network(item['imgUrl']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipePage(
                                recipeId: document.id,
                                recipeTitle: item['title']
                              )
                            ),
                          );
                          print(document.id);
                        },
                      ),
                    );
                  }
                )
              );
            }
          )
        ],
      ),
    );
  }
}
