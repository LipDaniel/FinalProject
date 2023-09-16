import 'package:flutter/material.dart';
import 'package:projectsem4/View/bottomnavi/bottomnavi_screen.dart';
import 'package:projectsem4/View/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color color = Colors.black;
  String? text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Montserrat-Regular",
        ),
        home: const Scaffold(body: Login()));
  }
}
