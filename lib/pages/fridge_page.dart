import 'package:flutter/material.dart';

class FridgePage extends StatefulWidget {
  @override
  _FridgePageState createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  List<String> fridgeItems = ['Apples', 'Bananas', 'Milk', 'Bread', 'Eggs'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fridge'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                fridgeItems = ['Apples', 'Bananas', 'Milk', 'Bread', 'Eggs'];
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: fridgeItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(fridgeItems[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    fridgeItems.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Ajoutez ici la logique pour ajouter un aliment manuellement
              // Vous pouvez afficher une boîte de dialogue ou naviguer vers une nouvelle page d'ajout
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Ajoutez ici la logique de numérisation pour ajouter des aliments
              // Vous pouvez utiliser une bibliothèque de numérisation de codes QR
            },
            child: Icon(Icons.qr_code),
          ),
        ],
      ),
    );
  }
}
