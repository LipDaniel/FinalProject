import 'package:flutter/material.dart';

class InforWidget extends StatelessWidget {
  const InforWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: _item(title: 'Full name', content: 'Mr. Danel'),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Seat',
                  style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'A7',
                  style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 30,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 3, child: _item(title: 'Address', content: '153')),
            Expanded(
                flex: 6,
                child: _item(title: 'Street', content: 'Hoàng Văn Thụ')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 3, child: _item(title: 'City', content: 'HCMC')),
            Expanded(
                flex: 6, child: _item(title: 'Passcode', content: '10030')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _item(title: 'Citizen ID / Passport', content: '079097006234'),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: _item(title: 'Checked baggage (kg)', content: '2.5')),
            Expanded(
                flex: 5, child: _item(title: 'Cabin baggage', content: '10.5')),
          ],
        ),
      ],
    );
  }

  Column _item({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          content,
          style: const TextStyle(
              fontFamily: 'Montserrat-Bold', fontSize: 16, color: Colors.black),
        )
      ],
    );
  }
}
