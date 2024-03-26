import 'package:flutter/material.dart';
import 'package:project/screens/image_upload.dart';
import 'package:project/screens/test_image_upload.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  final customTextColor = Color(0xFFFF9F68);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Display',
      home: ItemDisplayScreen(),
    );
  }
}

class ItemDisplayScreen extends StatefulWidget {
  @override
  _ItemDisplayScreenState createState() => _ItemDisplayScreenState();
}

class _ItemDisplayScreenState extends State<ItemDisplayScreen> {
  int _selectedIndex = 0;

  final List<Item> items = [
    Item('Item 1', 'Description for Item 1', 'assets/images/download.jpeg'),
    Item('Item 2', 'Description for Item 2', 'assets/images/2.jpeg'),
    // Item('Item 3', 'Description for Item 3', 'assets/item3.png'),
  ];

  List<Item> filteredItems = []; // List to store filtered items

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items); // Initialize filteredItems with all items
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = items.where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Display'),
        backgroundColor: Color(0xFFFF9F68),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // You can change the icon as needed
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestImage()),
              );
            },
          ),
        ],
      ),
      drawer: MyDrawer(), // Add the Drawer widget here
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterItems,
              decoration: InputDecoration(
                labelText: 'Search by Title',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ItemCard(item: filteredItems[index]);
                  },
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          // Add more items as needed
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF9F68),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }
}

class Item {
  final String title;
  final String description;
  final String imagePath;

  Item(this.title, this.description, this.imagePath);
}

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            width: 150.0,
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(item.title),
            subtitle: Text(item.description),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var customTextColor=Color(0xFFFF9F68);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color:customTextColor,
            ),
            child: Text(
              'Derma Solutions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.new_releases, color: Colors.red),
            title: Text(
              'New!',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.red, // Change the text color
              ),
            ),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.healing),
            title: Text('Detect Skin Diseases'),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageUploadScreen()),
              );
            },
          ),
          Divider(),

        ],
      ),
    );
  }
}



