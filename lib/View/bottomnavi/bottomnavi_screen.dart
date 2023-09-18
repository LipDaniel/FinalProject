import 'package:flutter/material.dart';
import 'package:projectsem4/View/home/home_screen.dart';
import 'package:projectsem4/View/profile/profile_screen.dart';
import 'package:projectsem4/constraint.dart';

class BottomNavigationBarApp extends StatefulWidget {
  const BottomNavigationBarApp({super.key});
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Notification',
      style: optionStyle,
    ),
    Text(
      'My Wallet',
      style: optionStyle,
    ),
    ProfileScreen()
  ];

  @override
  State<BottomNavigationBarApp> createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomNavigationBarApp._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 35.0,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstraint.mainColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // unselectedItemColor: const Color(0xffbebebe),
      ),
    );
  }
}
