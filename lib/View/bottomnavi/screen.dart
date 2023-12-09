// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/view/home/screen.dart';
import 'package:projectsem4/view/notification/screen.dart';
import 'package:projectsem4/view/profile/screen.dart';
import 'package:projectsem4/ulits/constraint.dart';

class BottomScreen extends StatefulWidget {
  BottomScreen({super.key, required this.listAir, required this.listClass});
  List<AirportModel> listAir;
  List<SeatClassModel> listClass;

  static List<Widget> getWidgetOptions(
      List<AirportModel> listAir, List<SeatClassModel> listClass) {
    return [
      HomeScreen(listAir: listAir, listClass: listClass),
      const NotificationScreen(),
      const Text(
        'My Wallet',
      ),
      const ProfileScreen()
    ];
  }

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
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
        child: BottomScreen.getWidgetOptions(widget.listAir, widget.listClass)
            .elementAt(_selectedIndex),
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
