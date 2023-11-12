import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipePage extends StatefulWidget {
  final String recipeId;
  final String recipeTitle;

  RecipePage({Key? key, required this.recipeId, required this.recipeTitle}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final user = FirebaseAuth.instance.currentUser;

  List<bool> addedToShoppingList = [];

  void addItemToShoppingList(String item, index) {
    setState(() {
      addedToShoppingList[index] = true;
    });
    if (item.isNotEmpty) {
      FirebaseFirestore.instance.collection('grocery').doc(user?.uid).get().then((snapshot) {
        Map<String, dynamic>? groceryList = snapshot.data();
        groceryList?['item'].add(item);
        groceryList?['check'].add(false);

        if (groceryList != null) {
          FirebaseFirestore.instance.collection('grocery').doc(user?.uid).set(groceryList);
        }
      });

    }
  }

  void addAllItemToShoppingList(items) {
    FirebaseFirestore.instance.collection('grocery').doc(user?.uid).get().then((snapshot) {
        Map<String, dynamic>? groceryList = snapshot.data();
        for (int index = 0; index < items.length; index++){
          groceryList?['item'].add(items[index]);
          groceryList?['check'].add(false);
          setState(() {
            addedToShoppingList[index] = true;
          });
        }

        if (groceryList != null) {
          FirebaseFirestore.instance.collection('grocery').doc(user?.uid).set(groceryList);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeTitle),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error.toString()}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.requireData.exists) {
            return Center(child: Text('La recette n\'existe pas.'));
          }

          Map<String, dynamic> recipeData = snapshot.requireData.data() as Map<String, dynamic>;

          for (int index = 0; index < recipeData['ingredients'].length; index++)
            addedToShoppingList.add(false);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(recipeData['imgUrl']),
                  for (int index = 0; index < recipeData['ingredients'].length; index++)
                    ListTile(
                      title: Text(recipeData['ingredients'][index]),
                      subtitle: Text('${recipeData['quantity'][index]} ${recipeData['unit'][index]}'),
                      trailing: IconButton(
                        icon: addedToShoppingList[index] ? Icon(Icons.check) : Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          if (addedToShoppingList[index] == false) {
                            addItemToShoppingList(recipeData['ingredients'][index], index);
                          }

                        },
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      addAllItemToShoppingList(recipeData['ingredients']); // Call function to add all items to shopping list
                    },
                    child: Text('Add All'),
                  ),
                  // Vous pouvez afficher d'autres détails de la recette ici
                  for (int index = 0; index < recipeData['recipe'].length; index++)
                    ListTile(
                      title: Text(recipeData['recipe'][index]),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}