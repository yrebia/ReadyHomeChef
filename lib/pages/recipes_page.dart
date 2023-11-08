import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipePage extends StatelessWidget {
  final String recipeId;
  final String recipeTitle;

  RecipePage({Key? key, required this.recipeId, required this.recipeTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeTitle),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').doc(recipeId).snapshots(),
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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(recipeData['imgUrl']),
                  for (int index = 0; index < recipeData['ingredients'].length; index++)
                    ListTile(
                      leading: Icon(Icons.check_circle),
                      title: Text(recipeData['ingredients'][index]),
                      subtitle: Text('${recipeData['quantity'][index]} ${recipeData['unit'][index]}'),
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