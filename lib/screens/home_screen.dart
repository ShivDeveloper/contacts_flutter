import 'package:flutter/material.dart';
import 'contacts_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;

  final screens = [
    ContactsScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: Container(
        width: size.width,
        height: size.height,
        child: screens[index],
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: index,

        onTap: (i) {
          setState(() {
            index = i;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}