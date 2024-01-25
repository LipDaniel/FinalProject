// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';
import 'package:projectsem4/ulits/constraint.dart';

class TimeAndPriceWidget extends StatelessWidget {
  TimeAndPriceWidget(
      {super.key,
      required this.passenger,
      required this.model,
      required this.isRoundTrip});
  PassengerModel? passenger;
  BusinessModel? model;
  bool? isRoundTrip;

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
    double? price;
    if (isRoundTrip == true) {
      price = model?.price_return;
    } else {
      price = model?.price;
    }
    num priceEachTicket = isPassenger == 'Adult'
        ? price!.toInt()
        : isPassenger == 'Children'
            ? price!.toInt() / 100 * 50
            : price!.toInt() / 100 * 20;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          isRoundTrip == true
                              ? model!.airport_to_code.toString()
                              : model!.airport_from_code.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          isRoundTrip == true
                              ? model!.time_to.toString()
                              : model!.time_from.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: AppConstraint.mainColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.asset(
                        'assets/image/arrow.png',
                        scale: 7.0,
                      ),
                    ),
                    
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          isRoundTrip == true
                              ? model!.airport_from_code.toString()
                              : model!.airport_to_code.toString(),
                          style: const TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          isRoundTrip == true
                              ? model!.time_from.toString()
                              : model!.time_to.toString(),
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
                  DateFormat.yMMMEd().format(DateTime.parse(isRoundTrip == true
                      ? model!.return_date.toString()
                      : model!.depart_date.toString())),
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
