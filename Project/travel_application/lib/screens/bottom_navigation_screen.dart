import 'package:flutter/material.dart';
import 'package:travel_application/screens/my_trips/my_trips_screen.dart';
import 'package:travel_application/screens/profile/profileScreen.dart';
import 'alltrips_screen.dart'; // Импорт всех экранов, которые используются

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children:  <Widget>[
          AllTripsScreen(),
          MyTripsScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'My trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
