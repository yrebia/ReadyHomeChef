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
                decoration: InputDecoration(labelText: 'Search by recipe name'),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 16,
                children: [
                  Container(
                    width: 100,
                    child: FilterChip(
                      label: Text('Filter 1'),
                      onSelected: (selected) {
                        // Handle filter selection
                      },
                      backgroundColor: Colors.orange,
                      selected: false,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: FilterChip(
                      label: Text('Filter 2'),
                      onSelected: (selected) {
                        // Handle filter selection
                      },
                      backgroundColor: Colors.orange,
                      selected: false,
                    ),
                  ),
                  // Add more filters here
                ],
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

                      return ListTile(
                        title: Text(recipe['title']),
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
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
    );
  }
}
