// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/confirm/widgets/info_widget.dart';
import 'package:projectsem4/View/confirm/widgets/time_price_widget.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';
import 'package:projectsem4/ulits/constraint.dart';

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({super.key, required this.model});
  BusinessModel model;
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  
  String totalPrice(){
    var total = 0;
    List<PassengerModel>? passengers = widget.model.passenger_list;
    for (var item in passengers!) {
      int priceEachTicket = widget.model.price!.toInt();
      int checkedBaggagePrice = item.checked_baggage != '' ? (int.parse(item.checked_baggage!.substring(0, 2))) * 10000 : 0;
      int cabinBaggagePrice = item.cabin_baggage != '' ? (int.parse(item.cabin_baggage!.substring(0, 2))) * 10000 : 0;
      int subtotal = priceEachTicket + checkedBaggagePrice + cabinBaggagePrice;
      total += subtotal;
    }
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(total);
    return '$priced đ';
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      bottomSheet: _btn(),
      appBar: AppBar(
        backgroundColor: AppConstraint.mainColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          'Confirm'.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppConstraint.fontFamilyBold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  ...widget.model.passenger_list!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isLastItem =
                        index == widget.model.passenger_list!.length - 1;
                    final seat = widget.model.seatList;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(
                            children: [
                              InforWidget(seat: seat![index], passenger: item),
                              const SizedBox(
                                height: 20,
                              ),
                              TimeAndPriceWidget(
                                  passenger: item, model: widget.model),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        if (!isLastItem)
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 2,
                            dashLength: 17,
                            dashColor: Colors.grey.withOpacity(0.5),
                            dashGapLength: 8,
                          ),
                        if (!isLastItem)
                          const SizedBox(
                            height: 5,
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 15,
                    blurStyle: BlurStyle.normal)
              ],
              color: const Color.fromARGB(255, 243, 242, 242),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TOTAL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(totalPrice(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            decoration: const BoxDecoration(
                color: AppConstraint.mainColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: const Center(
              child: Text(
                'Checkout',
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
