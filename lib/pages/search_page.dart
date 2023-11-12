import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_home_chef/pages/recipes_page.dart';

class SearchRecipePage extends StatefulWidget {
  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  String searchQuery = '';
  Stream<QuerySnapshot>? searchResults;

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query;
      if (query.isNotEmpty) {
        final lowercaseQuery = query.toLowerCase();
        searchResults = FirebaseFirestore.instance
            .collection('recipes')
            .where('title_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
            .where('title_lowercase', isLessThan: lowercaseQuery + 'z')
            .snapshots();
      } else {
        searchResults = FirebaseFirestore.instance.collection('recipes').snapshots();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    searchResults = FirebaseFirestore.instance.collection('recipes').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: updateSearchResults,
              decoration: InputDecoration(
                labelText: 'Search by recipe name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error.toString()}'));
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No recipes found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot recipe = snapshot.data!.docs[index];
                    String recipeId = recipe.id;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(
                            recipe['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            'Tap to view recipe',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipePage(
                                  recipeId: recipeId,
                                  recipeTitle: recipe['title'],
                                ),
                              ),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipe['imgUrl'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
