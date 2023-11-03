import 'package:flutter/material.dart';

class GroceryListPage extends StatefulWidget {
  final List<String> groceryItems = [
    'Apples',
    'Bananas',
    'Milk',
    'Bread',
    'Eggs',
  ];

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  String searchText = '';
  List<String> filteredGroceryItems = [];

  @override
  Widget build(BuildContext context) {
    // Filter the grocery items based on the search text
    filteredGroceryItems = widget.groceryItems
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for items...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchText = '';
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGroceryItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredGroceryItems[index]),
                  // You can add more widgets or actions here for each item
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
