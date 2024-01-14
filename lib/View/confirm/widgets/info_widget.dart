// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';

class InforWidget extends StatelessWidget {
  InforWidget({super.key, this.seat, this.index, this.passenger, this.model});
  String? seat;
  int? index;
  BusinessModel? model;
  PassengerModel? passenger;
  @override
  Widget build(BuildContext context) {
    seat = model!.isRoundTrip == true ? '$seat - ${model!.seatList_return?[index!]}' : seat;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: _item(title: 'Full name', content: '${passenger!.title} ${passenger!.name}'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Seat',
                  style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  seat.toString(),
                  style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: model!.isRoundTrip == true ? 20 : 30,
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
            Expanded(flex: 5, child: _item(title: 'Country', content: '${passenger!.country}')),
            Expanded(
                flex: 5,
                child: _item(title: 'National', content: '${passenger!.national}')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 5, child: _item(title: 'Citizen ID / Passport', content: '${passenger!.passport}')),
            Expanded(
                flex: 5, child: _item(title: 'Expire date', content: '${passenger!.expire_date}')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _item(title: 'Date of birth', content: '${passenger!.birth}'),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: _item(title: 'Checked baggage (kg)', content: '${passenger!.checked_baggage != '' ? passenger!.checked_baggage : 0}')),
            Expanded(
                flex: 5, child: _item(title: 'Cabin baggage (kg)', content: '${passenger!.cabin_baggage != '' ? passenger!.cabin_baggage : 0}')),
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
