import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/card_user.dart'; // Assurez-vous d'importer le composant UserCard ici

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          UserCard(
            username: 'Username',
            imageUrl: 'URL_de_l_image', // Remplacez par l'URL réelle de l'image
          ),
          // Ajoutez d'autres éléments au besoin
        ],
      ),
    );
  }
}
