import 'package:flutter/material.dart';
import 'package:projectsem4/View/confirm/confirm_screen.dart';
import 'package:projectsem4/ulits/constraint.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstraint.mainColor,
        title: const Text('PASSENGER INFORMATION',
            style: TextStyle(fontSize: 16,fontFamily: AppConstraint.fontFamilyBold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _passengerForm(),
            _passengerForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      bottomSheet: _btn(),
    );
  }

  Container _passengerForm() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(flex: 15, child: _textField('Full name')),
            const SizedBox(width: 15),
            _seat()
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(flex: 4, child: _textField('Address')),
            const SizedBox(width: 15),
            Expanded(flex: 7, child: _textField('Street'))
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(flex: 4, child: _textField('City')),
            const SizedBox(width: 15),
            Expanded(flex: 7, child: _textField('Passcode'))
          ]),
          const SizedBox(height: 20),
          _textField('Citizen ID / Passport'),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(flex: 5, child: _textField('Checked baggage')),
            const SizedBox(width: 15),
            Expanded(flex: 5, child: _textField('Cabin baggage'))
          ]),
          const SizedBox(height: 35),
          const Text('* Free 23kg checked baggage',
              style: TextStyle(color: AppConstraint.colorLabel)),
          const Text('* Free 12kg cabin baggage',
              style: TextStyle(color: AppConstraint.colorLabel)),
        ]));
  }

  Expanded _seat() {
    return const Expanded(
        flex: 2,
        child: Column(
          children: [
            Text('Seat',
                style:
                    TextStyle(fontSize: 15, color: AppConstraint.colorLabel)),
            Text('A7',
                style: TextStyle(
                    fontSize: 25, fontFamily: AppConstraint.fontFamilyBold))
          ],
        ));
  }

  TextField _textField(String labelInput) {
    return TextField(
        scrollPadding: const EdgeInsets.all(2),
        cursorColor: AppConstraint.colorLabel,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(0),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.colorInput)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.mainColor)),
            label: Text(labelInput, style: const TextStyle(fontSize: 14)),
            labelStyle: const TextStyle(color: AppConstraint.colorLabel)));
  }

  Widget _btn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: InkWell(
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => const ConfirmScreen(),
                  fullscreenDialog: true);
              Navigator.push(context, route);
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  color: AppConstraint.mainColor, borderRadius: BorderRadius.circular(30)),
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
        ),
      ],
    );
  }
}
