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
      bottomSheet: _btn(),
      appBar: AppBar(
        backgroundColor: AppConstraint.mainColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
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

  Widget _btn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            decoration: BoxDecoration(
                color: AppConstraint.mainColor,
                borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}