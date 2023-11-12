import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({Key? key}) : super(key: key);

  @override
  _FridgePageState createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  final user = FirebaseAuth.instance.currentUser;
  String? newItemName = '';
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  void addItemToFirebase() {
    if (newItemName!.isNotEmpty) {
      // Ajouter l'élément dans Firebase.
      FirebaseFirestore.instance
          .collection('fridge')
          .doc(user?.uid)
          .update({
        'items': FieldValue.arrayUnion([newItemName]),
      });
      newItemName = '';
    }
  }

  void deleteItemToFirebase(String item) {
    if (item.isNotEmpty) {
      // Ajouter l'élément dans Firebase.
      FirebaseFirestore.instance
          .collection('fridge')
          .doc(user?.uid)
          .update({
        'items': FieldValue.arrayRemove([item]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Future<void> searchFood(String? query) async {

    try {
      final configuration = ProductQueryConfiguration(
        query!,
        language: OpenFoodFactsLanguage.FRENCH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      );

      ProductResultV3 result = await OpenFoodAPIClient.getProductV3(configuration);
      print(result.product?.productName);
      setState(() {
        newItemName = result.product?.productName.toString();
      });
      addItemToFirebase();
    } catch (error) {
      print("error");
    }
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fridge'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('fridge')
            .doc(user?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Le réfrigérateur est vide.'));
          }

          // Obtenez les données du document "fridge".
          Map<String, dynamic> fridgeData = snapshot.data?.data() as Map<String, dynamic>;

          // Récupérez les éléments du réfrigérateur.
          List<dynamic> fridgeItems = fridgeData['items'];

          if (fridgeItems.isEmpty) {
            return Center(child: Text('Aucun élément dans le réfrigérateur.'));
          }

          // Construisez la liste d'éléments à partir des données Firestore.
          List<Widget> elements = fridgeItems.map((item) {
            return ListTile(
            title: Text(item.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteItemToFirebase(item.toString());
              },
              ),
            );
          }).toList();

          return ListView(
            children: elements,
          );
        },
      ),
     floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "tag1",
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add a New Aliment'),
                    content: TextField(
                      onChanged: (value) {
                        newItemName = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          addItemToFirebase();
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            heroTag: "tag2",
            onPressed: () {
              _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                context: context,
                onCode: (code) {
                  searchFood(code);
                },
              );
            },
            child: Icon(Icons.qr_code),
            backgroundColor: Colors.orange,
          )
        ],
      ),
    );
  }
}