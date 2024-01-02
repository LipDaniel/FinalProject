// ignore_for_file: must_be_immutable, prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectsem4/View/setting/screen.dart';
import 'package:projectsem4/View/tickets/screen.dart';
import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/model/ticket_model.dart';
import 'package:projectsem4/repository/bill_repo.dart';
import 'package:projectsem4/view/home/screen.dart';
import 'package:projectsem4/view/notification/screen.dart';
import 'package:projectsem4/ulits/constraint.dart';

class BottomScreen extends StatefulWidget {
  BottomScreen({super.key, this.tab});
  int? tab;

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  late String _fname;
  late String _lname;
  late String _id = '0';
  late List<AirportModel> lstAir;
  late List<SeatClassModel> lstClass;
  late String _welcomeMessage;
  late int _selectedIndex;
  late List<TicketsModel> ticketList = [];

  static List<Widget> getWidgetOptions(List<dynamic>? listAir,
      List<dynamic>? listClass, List<TicketsModel> tickets) {
    return [
      HomeScreen(
          listAir: listAir! as List<AirportModel>,
          listClass: listClass! as List<SeatClassModel>),
      const NotificationScreen(),
      TicketsScreen(ticketList: tickets),
      const SettingScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tab != null ? widget.tab as int : 0;
    _loadUserData();
  }

  Future<void> _getTicketList() async {
    Map<String, dynamic> params = {'_cus_id': int.parse(_id)};

    var response = await BillRepository.getTicketList(params);
    setState(() {
      ticketList = response;
    });
  }

  Future<void> _loadUserData() async {
    _fname = await AppConstraint.loadData('fname') ?? '';
    _lname = await AppConstraint.loadData('lname') ?? '';
    var userId = await AppConstraint.loadData('id') ?? '';

    var listAirJson = jsonDecode(await AppConstraint.loadData('lstAir') ?? '[]')
        as List<dynamic>;
    var listClassJson =
        jsonDecode(await AppConstraint.loadData('lstClass') ?? '[]')
            as List<dynamic>;

    // Convert each item in the JSON list to AirportModel
    lstAir = listAirJson.map((json) => AirportModel.fromJson(json)).toList();
    lstClass =
        listClassJson.map((json) => SeatClassModel.fromJson(json)).toList();

    setState(() {
      _welcomeMessage = 'Welcome $_fname $_lname!';
      _id = userId;
      _getTicketList();
    });

    AppConstraint.successToast(_welcomeMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getWidgetOptions(lstAir, lstClass, ticketList)
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
            icon: Icon(Icons.account_circle),
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
