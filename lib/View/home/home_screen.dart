import 'package:flutter/material.dart';
import 'package:projectsem4/constraint.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [_header(context), _searchForm(context)],
      ),
    );
  }

  Positioned _searchForm(BuildContext context) {
    return Positioned(
      top: 250,
      right: 30,
      left: 30,
      child: Container(
        height: calculateFormHeight(
            MediaQuery.sizeOf(context).height,
            MediaQuery.sizeOf(context).height * 0.33,
            kBottomNavigationBarHeight),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(5, 0), blurRadius: 10)
            ],
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Row(),
      ),
    );
  }

  Container _header(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.33;
    return Container(
      height: height,
      decoration: const BoxDecoration(
          color: AppConstraint.mainColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0))),
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start',
                style: TextStyle(
                    fontSize: 80,
                    color: AppConstraint.colorSlogan,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic,
                    height: 1.2)),
            Text(
              'Your Moment',
              style: TextStyle(
                  fontSize: 30,
                  color: AppConstraint.colorSubSlogan,
                  fontWeight: FontWeight.bold,
                  height: 1.0),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/image/flight.png',
          scale: 3.8,
        )
      ]),
    );
  }
}
