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
  int people = 1;

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
      for (int index = 0; index < items.length; index++) {
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error.toString()}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.requireData.exists) {
            return const Center(child: Text('La recette n\'existe pas.'));
          }

          Map<String, dynamic> recipeData = snapshot.requireData.data() as Map<String, dynamic>;

          for (int index = 0; index < recipeData['ingredients'].length; index++) {
            addedToShoppingList.add(false);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipeTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
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
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      recipeData['imgUrl'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (people > 1) {
                                setState(() {
                                  people -= 1;
                                });
                              }
                            },
                          ),
                          Text(" $people "),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                people += 1;
                              });
                            },
                          ),
                        ],
                      ),

                      Text("Price : ${(recipeData['price'] * people).toStringAsFixed(2)}€"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ingrédients:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (int index = 0; index < recipeData['ingredients'].length; index++)
                    Column(
                      children: [
                        ListTile(
                          title: Text(recipeData['ingredients'][index]),
                          subtitle: Text(
                            '${recipeData['quantity'][index] * people} ${recipeData['unit'][index]}',
                          ),
                          trailing: IconButton(
                            icon: addedToShoppingList[index]
                                ? const Icon(Icons.check, color: Colors.green)
                                : const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              if (addedToShoppingList[index] == false) {
                                addItemToShoppingList(
                                  recipeData['ingredients'][index],
                                  index,
                                );
                              }
                            },
                          ),
                        ),
                        const Divider(), // Separator between ingredients
                      ],
                    ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          addAllItemToShoppingList(recipeData['ingredients']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          shadowColor: Colors.black,
                          elevation: 5,
                        ),
                        child: const Text(
                          'Ajouter tout à la liste de courses',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Préparation:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipeData['recipe'].length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              recipeData['recipe'][index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    },
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
