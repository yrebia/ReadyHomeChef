import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ready_home_chef/pages/recipes_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MakableRecipesCarousel extends StatelessWidget {
  MakableRecipesCarousel({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  Future<List<Map<String, dynamic>>> getMatchingRecipes() async {
    List<Map<String, dynamic>> matchingRecipes = [];
    await FirebaseFirestore.instance.collection('fridge').doc(user?.uid).get().then((snapshot) async {
      Map<String, dynamic>? fridgeItem = snapshot.data() as Map<String, dynamic>?;

      if (fridgeItem != null && fridgeItem.containsKey('items')) {
        List<String> items = List<String>.from(fridgeItem['items']);
        
        QuerySnapshot recipesSnapshot = await FirebaseFirestore.instance.collection('recipes').get();

        for (QueryDocumentSnapshot doc in recipesSnapshot.docs) {
          Map<String, dynamic> recipeData = doc.data() as Map<String, dynamic>;
          List<String> recipeIngredients = List<String>.from(recipeData['ingredients']);
          bool test = false;
          int i = 0;

          for (String ingredient in recipeIngredients) {
            test = false;
            for (String item in items) {
              if (item.toLowerCase() == ingredient.toLowerCase() && !test) {
                i += 1;
                test = true;
              }
            }
          }

          if (i == recipeIngredients.length) {
            recipeData['id'] = doc.id;
            matchingRecipes.add(recipeData);
          }
        }
      }
    });

    return matchingRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getMatchingRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> matchingRecipes = snapshot.data ?? [];
        
        if (matchingRecipes.isEmpty) {
          return Center(child: Text('No matching recipes found.'));
        }

        List<String> recipeImages = matchingRecipes.map((doc) {
          return doc['imgUrl'] as String;
        }).toList();

        List<String> recipeNames = matchingRecipes.map((doc) {
          return doc['title'] as String;
        }).toList();

        List<String> recipeIds = matchingRecipes.map((doc) {
          return doc['id'] as String;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                enableInfiniteScroll: (recipeIds.length == 1) ? false : true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                enlargeCenterPage: true,
              ),
              items: recipeImages.asMap().entries.map((entry) {
                final int index = entry.key;
                final String imagePath = entry.value;
                final String recipeName = recipeNames[index];
                final String recipeId = recipeIds[index];

                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipePage(
                              recipeId: recipeId,
                              recipeTitle: recipeName,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                recipeName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: recipeImages.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
