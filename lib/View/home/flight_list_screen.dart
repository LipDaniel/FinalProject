import 'package:flutter/material.dart';
import 'package:projectsem4/constraint.dart';

class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppConstraint.mainColor,
        title: _flightinfo(),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        children: [
          _flightItem("12:30", "14:50", "SGN", "VCS", "Economy Class",
              "2.590.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("13:30", "15:50", "SGN", "VCS", "Economy Class",
              "2.850.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("15:30", "16:50", "SGN", "VCS", "Economy Class",
              "2.780.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("17:30", "19:50", "SGN", "VCS", "Economy Class",
              "3.150.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("18:30", "20:50", "SGN", "VCS", "Economy Class",
              "2.678.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("19:10", "20:20", "SGN", "VCS", "Economy Class",
              "3.370.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("20:40", "22:00", "SGN", "VCS", "Economy Class",
              "2.050.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("21:20", "22:30", "SGN", "VCS", "Economy Class",
              "2.250.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("21:40", "23:00", "SGN", "VCS", "Economy Class",
              "2.890.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
          _flightItem("22:00", "21:50", "SGN", "VCS", "Economy Class",
              "3.450.000 đ", "Vietnam Air Services (VASCO)", "2h 40p"),
        ],
      ),
    );
  }

  InkWell _flightItem(
      timeFrom, timeTo, from, to, seatClass, price, airlines, flightTime) {
    return InkWell(
      onTap: () => {},
      child: Container(
          decoration: BoxDecoration(
              color: AppConstraint.colorSlogan,
              border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
          height: 120,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/image/logo_airline.png', width: 35),
                  const SizedBox(width: 15),
                  Column(children: [
                    Text(
                      timeFrom,
                      style: const TextStyle(
                          fontFamily: AppConstraint.fontFamilyBold,
                          fontSize: 21,
                          letterSpacing: 2),
                    ),
                    Text(
                      from,
                      style: const TextStyle(fontSize: 17, letterSpacing: 2),
                    )
                  ]),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Image.asset('assets/image/arrow.png',
                          width: 60, height: 25, fit: BoxFit.fill),
                      Text(flightTime,
                          style: const TextStyle(
                              color: AppConstraint.colorLabel, fontSize: 11))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      timeTo,
                      style: const TextStyle(
                          fontFamily: AppConstraint.fontFamilyBold,
                          fontSize: 21,
                          letterSpacing: 2),
                    ),
                    Text(
                      to,
                      style: const TextStyle(fontSize: 17, letterSpacing: 2),
                    )
                  ]),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      Text(seatClass,
                          style:
                              const TextStyle(color: AppConstraint.colorLabel)),
                      Text(price,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 217, 111, 104),
                              fontFamily: AppConstraint.fontFamilyBold,
                              fontSize: 18))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text("Operated by $airlines",
                  style: const TextStyle(color: AppConstraint.colorLabel))
            ],
          )),
    );
  }

  InkWell _flightinfo() {
    return InkWell(
      onTap: () => {print(1)},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "SGN",
                style: TextStyle(
                    fontFamily: AppConstraint.fontFamilyBold, fontSize: 27),
              ),
              Text(
                "Viet Nam",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_right_alt),
          SizedBox(width: 5),
          Column(
            children: [
              Text("VCS",
                  style: TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold, fontSize: 27)),
              Text("Viet Nam", style: TextStyle(fontSize: 15))
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Text('Thu, 9 SEP, 2023',
                  style: TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold, fontSize: 20)),
              Text('2 Adult, 1 Children, 1 Baby',
                  style: TextStyle(fontSize: 12))
            ],
          )
        ],
      ),
    );
  }
}
