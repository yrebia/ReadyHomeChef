import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroceryListPage extends StatefulWidget {
  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController itemController = TextEditingController();

  void addItemOnGroceryList() {
    if (itemController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('grocery').doc(user?.uid).get().then((snapshot) {
        Map<String, dynamic>? groceryList = snapshot.data();
        groceryList?['item'].add(itemController.text);
        groceryList?['check'].add(false);

        if (groceryList != null) {
          FirebaseFirestore.instance.collection('grocery').doc(user?.uid).set(groceryList);
        }
        itemController.text = '';
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent, // Définit l'arrière-plan comme transparent
  elevation: 0, // Supprime l'ombre sous la barre d'applications
  title: Text(''), 
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Item'),
                    content: TextField(
                      controller: itemController,
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          itemController.text = '';
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Add'),
                        onPressed: () {
                          addItemOnGroceryList();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
            primary: Colors.orange, // Couleur de fond bleue
            onPrimary: Colors.white, // Couleur du texte orange
          ),
            child: Row(
              children: [
                Icon(Icons.add,),
                Text('Add new element'),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your grocery list',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Here you can add and delete elements on your list.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('grocery').doc(user?.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> groceryList = snapshot.data?.data() as Map<String, dynamic>;
                List<String> item = List<String>.from(groceryList['item'] ?? []);
                List<bool> check = List<bool>.from(groceryList['check'] ?? []);

                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    String i = item[index];
                    bool isChecked = check[index];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(
                          i,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            decoration: isChecked ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              groceryList['check'][index] = !isChecked;
                              FirebaseFirestore.instance.collection('grocery').doc(user?.uid).set(groceryList);
                            });
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              item.removeAt(index);
                              check.removeAt(index);
                              groceryList['item'] = item;
                              groceryList['check'] = check;
                              FirebaseFirestore.instance.collection('grocery').doc(user?.uid).set(groceryList);
                            });
                          },
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
