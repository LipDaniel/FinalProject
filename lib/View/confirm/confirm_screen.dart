// ignore_for_file: must_be_immutable, unused_local_variable, avoid_print

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/confirm/widgets/info_widget.dart';
import 'package:projectsem4/View/confirm/widgets/time_price_widget.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';
import 'package:projectsem4/repository/bill_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({super.key, required this.model});
  BusinessModel model;
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late String userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userId = await AppConstraint.loadData('id') ?? '';
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

  handleCreateJson() {
    var data = {
      "_bil": {
        "_bil_cus_id": userId,
        "_bil_payment": totalPrice(),
        "_bil_payment_type": "",
        "_bil_fl_id": widget.model.fl_id,
        "_bil_payment_code": ""
      },
      "_tickets": []
    };
    List<PassengerModel>? passengers = widget.model.passenger_list;
    for (var item in passengers!) {
      var isPassenger = passengerClassification(item.birth);
      num priceEachTicket = isPassenger == 'Adult'
          ? widget.model.price!.toInt()
          : isPassenger == 'Children'
              ? widget.model.price!.toInt() / 100 * 50
              : widget.model.price!.toInt() / 100 * 20;
      int checkedBaggagePrice = item.checked_baggage != ''
          ? (int.parse(item.checked_baggage!.substring(0, 2))) * 10000
          : 0;
      int cabinBaggagePrice = item.cabin_baggage != ''
          ? (int.parse(item.cabin_baggage!.substring(0, 2))) * 10000
          : 0;
      num subtotal = priceEachTicket + checkedBaggagePrice + cabinBaggagePrice;
      var passenger_tiket = {
        "_tk_payment": subtotal,
        "_tk_full_name": item.name,
        "_tk_dob": item.birth,
        "_tk_nationality": item.national,
        "_tk_passport": item.passport,
        "_tk_country": item.country,
        "_tk_passport_expired": item.expire_date,
        "_tk_title": item.title,
        "_tk_pas_id": isPassenger == 'Adult'
            ? 1
            : isPassenger == 'Children'
                ? 2
                : 3,
        "_tk_guardian_id":
            isPassenger == 'Baby' || isPassenger == 'Children' ? '' : 0,
        "_tk_seat": item.seat,
        "_tk_return_type": 1,
        "_tk_tc_id": widget.model.seatclass_id,
        "_tk_cabin": 0,
        "_tk_free_cabin": 0,
        "_tk_checked": 0,
        "_tk_free_checked": 0
      };
      var tickets = data["_tickets"] as List<dynamic>;

      tickets.add(passenger_tiket);
    }

    return data;
  }

  void handleInsertBill() async {
    await EasyLoading.show();
    var data = handleCreateJson();
    var response = await BillRepository.insertBill(data);
    if (response == 'Create ticket successfully') {
      await AppConstraint.successToast(response);
      await EasyLoading.dismiss();
    } else {
      await AppConstraint.errorToast(response);
      await EasyLoading.dismiss();
      return;
    }
  }

  num totalPrice() {
    num total = 0;
    List<PassengerModel>? passengers = widget.model.passenger_list;
    for (var item in passengers!) {
      var isPassenger = passengerClassification(item.birth);
      num priceEachTicket = isPassenger == 'Adult'
          ? widget.model.price!.toInt()
          : isPassenger == 'Children'
              ? widget.model.price!.toInt() / 100 * 50
              : widget.model.price!.toInt() / 100 * 20;
      int checkedBaggagePrice = item.checked_baggage != ''
          ? (int.parse(item.checked_baggage!.substring(0, 2))) * 10000
          : 0;
      int cabinBaggagePrice = item.cabin_baggage != ''
          ? (int.parse(item.cabin_baggage!.substring(0, 2))) * 10000
          : 0;
      num subtotal = priceEachTicket + checkedBaggagePrice + cabinBaggagePrice;
      total += subtotal;
    }
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(total);
    return total;
  }

  String formatPrice() {
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(totalPrice());
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
              Text(formatPrice(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
        ),
        InkWell(
          onTap: () => handleInsertBill(),
          child: Padding(
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
        ),
      ],
    );
  }
}
