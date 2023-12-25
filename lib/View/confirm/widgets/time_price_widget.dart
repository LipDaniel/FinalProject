// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';
import 'package:projectsem4/ulits/constraint.dart';

class TimeAndPriceWidget extends StatelessWidget {
  TimeAndPriceWidget({super.key, this.passenger, this.model});
  PassengerModel? passenger;
  BusinessModel? model;

  String formatMoney(num money) {
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(money);
    return '$priced đ';
  }

  String passengerClassification(String? birthDateStr) {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateFormat('dd-MM-yyyy').parse(birthDateStr!);
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    if (age > 12) {
      return "Adult";
    } else {
      if (age > 2 && age <= 12) {
        return "Children";
      } else {
        return "Baby";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPassenger = passengerClassification(passenger!.birth); 
    // int priceEachTicket = model!.price!.toInt();
      num priceEachTicket = isPassenger == 'Adult'
        ? model!.price!.toInt()
        : isPassenger == 'Children'
            ? model!.price!.toInt() / 100 * 50
            : model!.price!.toInt() / 100 * 20;

    int checkedBaggagePrice = passenger!.checked_baggage! != ''
        ? (int.parse(passenger!.checked_baggage!.substring(0, 2))) * 10000
        : 0;
    int cabinBaggagePrice = passenger!.cabin_baggage! != ''
        ? (int.parse(passenger!.cabin_baggage!.substring(0, 2))) * 10000
        : 0;
    num totalPriceEach =
        priceEachTicket + checkedBaggagePrice + cabinBaggagePrice;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          model!.airport_from_code.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          model!.time_from.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: AppConstraint.mainColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.asset(
                        'assets/image/icon_arrow_right.png',
                        scale: 1.5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          model!.airport_to_code.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          model!.time_to.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: AppConstraint.mainColor),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat.yMMMEd()
                      .format(DateTime.parse(model!.depart_date.toString())),
                  style: const TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 16,
                      color: AppConstraint.mainColor),
                )
              ],
            )),
        Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          formatMoney(priceEachTicket),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Baggage',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          formatMoney(checkedBaggagePrice + cabinBaggagePrice),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  formatMoney(totalPriceEach),
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat-Bold',
                      color: AppConstraint.mainColor),
                ),
              ],
            ))
      ],
    );
  }
}
