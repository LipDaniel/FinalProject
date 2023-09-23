import 'package:flutter/material.dart';
import 'package:projectsem4/ulits/constraint.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
