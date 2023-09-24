import 'package:flutter/material.dart';
import 'package:projectsem4/View/choose_seat/widgets/seat_widget.dart';
import 'package:projectsem4/ulits/constraint.dart';

class ChooseSeetScreen extends StatefulWidget {
  const ChooseSeetScreen({super.key});

  @override
  State<ChooseSeetScreen> createState() => _ChooseSeetScreenState();
}

class _ChooseSeetScreenState extends State<ChooseSeetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstraint.mainColor,
        elevation: 0,
        // leading: const BackButton(
        //   color: Colors.black,
        // ),
        title: Text(
          'Choose seats'.toUpperCase(),
          style: const TextStyle(
              fontSize: 16, fontFamily: AppConstraint.fontFamilyBold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _lstStatus(),
            const SizedBox(
              height: 20,
            ),
            const SeatWidget(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row _lstStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Reserved',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: AppConstraint.mainColor,
                  borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Selected',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Available',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            )
          ],
        ),
      ],
    );
  }
}
