import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String username;
  final String imageUrl;

  UserCard({
    required this.username,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Ombre légère
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Coins légèrement arrondis
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: Image.network(
              imageUrl, // URL de l'image de profil
              width: double.infinity,
              height: 200, // Ajustez la hauteur selon vos besoins
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              username,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
