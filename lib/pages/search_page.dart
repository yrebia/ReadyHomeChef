import 'package:firebase_auth/firebase_auth.dart';
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
  late String uid;
  Map<String, bool> filters = {};
  bool showFilters = false;

  bool isFilterEmpty() {
    bool test = true;
    filters.forEach((key, value) {
      if (value == true) {
        test = false;
      }
    });
    print(test);
    return test;
  }

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query;
      if (query.isNotEmpty) {
        final lowercaseQuery = query.toLowerCase();
        if (isFilterEmpty()) {
          searchResults = FirebaseFirestore.instance
            .collection('recipes')
            .where('title_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
            .where('title_lowercase', isLessThan: lowercaseQuery + 'z')
            .snapshots();
        } else {
          searchResults = FirebaseFirestore.instance
            .collection('recipes')
            .where('title_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
            .where('title_lowercase', isLessThan: lowercaseQuery + 'z')
            .where('filter', arrayContainsAny: filters.entries.where((e) => e.value).map((e) => e.key).toList())
            .snapshots();
        }
      } else {
        if (isFilterEmpty()) {
          searchResults = FirebaseFirestore.instance.collection('recipes').snapshots();
        } else {
          searchResults = FirebaseFirestore.instance.collection('recipes')
            .where('filter', arrayContainsAny: filters.entries.where((e) => e.value).map((e) => e.key).toList())
            .snapshots();
        }
      }
    });
  }

  void getFiltersForUser() {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        // Update the filters map based on the data fetched from Firestore
        setState(() {
          filters = {
            'vegetarian': doc['restriction']['vegetarian'],
            'pescatarian': doc['restriction']['pescatarian'],
            'noDairy': doc['restriction']['noDairy'],
            'noPork': doc['restriction']['noPork'],
            'vegan': doc['restriction']['vegan'],
            'noGluten': doc['restriction']['noGluten'],
          };
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        uid = user.uid;
        getFiltersForUser(); // Retrieve filter values for the current user.
      }
    });
    searchResults = FirebaseFirestore.instance.collection('recipes').snapshots();
  }

  Widget buildFilterRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filters.keys.map((filter) {
        return CheckboxListTile(
          title: Text(filter),
          value: filters[filter],
          onChanged: (bool? value) {
            setState(() {
              filters[filter] = value!;
            });
            updateSearchResults('');
          },
        );
      }).toList(),
    );
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
          const SizedBox(height: 10),
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
          // filtres
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Filters'),
              SizedBox(width: 8),
              Switch(
                value: showFilters,
                onChanged: (value) {
                  setState(() {
                    showFilters = value;
                  });
                },
              ),
            ],
          ),
          if (showFilters) buildFilterRow(),
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
