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
        title: Text('Grocery List'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
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

              return ListTile(
                title: Text(i),
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
                  icon: Icon(Icons.delete),
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
