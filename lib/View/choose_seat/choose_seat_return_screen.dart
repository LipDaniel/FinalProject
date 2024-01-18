// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/seat_model.dart';
import 'package:projectsem4/repository/seat_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:projectsem4/view/information/screen.dart';

class ChooseSeetReturnScreen extends StatefulWidget {
  ChooseSeetReturnScreen({super.key, required this.model, required this.data});
  BusinessModel model = BusinessModel();
  List<SeatModel> data = [];
  @override
  State<ChooseSeetReturnScreen> createState() => _ChooseSeetReturnScreenState();
}

class _ChooseSeetReturnScreenState extends State<ChooseSeetReturnScreen> {
  SeatModel? seatSelected;
  List<SeatModel> lstSelected = [];
  List<SeatModel> newSeats = [];

  @override
  void initState() {
    super.initState();
    widget.data =
        widget.data.where((element) => !element.sCode!.contains('G')).toList();
  }

  void handleChooseSeats() async {
    List<String?> tcCode = lstSelected.map((e) => e.sCode).toList();
    bool check_enough = is_seat_enough(tcCode);
    if (!check_enough) {
      AppConstraint.warningToast('Please select the correct number of seats');
      return;
    }
    await EasyLoading.show();
    Map<String, dynamic> params = {
      "_fl_id": widget.model.fl_id_return as int,
      "_tc_id": widget.model.seatclass_id,
      '_tc_code': tcCode, // Convert the LinkedList to JSON string
    };
    var response = await SeatClassRepository.checkSeat(params);
    if (response == true) {
      widget.model.seatList_return =
          lstSelected.map((e) => e.sCode).cast<String>().toList();
      Route route = MaterialPageRoute(
          builder: (context) => InformationScreen(model: widget.model));
      Navigator.push(context, route);
      await EasyLoading.dismiss();
    }
  }

  bool is_seat_enough(List<String?> tcCode) {
    int? amount = widget.model.baby_amount! +
        widget.model.adult_amount! +
        widget.model.children_amount!;
    int seatSelected = tcCode.length;
    if (amount != seatSelected) {
      return false;
    }
    return true;
  }

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
              fontSize: 16,
              fontFamily: AppConstraint.fontFamilyBold,
              color: Colors.white),
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
            _seatWidget(),
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
              height: 35,
              width: 35,
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
              height: 35,
              width: 35,
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
              height: 35,
              width: 35,
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

  Container _seatWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.sizeOf(context).width,
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
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/image/logo-airline.png',
            height: 40,
          ),
          Text(
            widget.model.airline.toString(),
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
              DateFormat.yMMMMEEEEd()
                  .format(DateTime.parse(widget.model.return_date as String)),
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 5,
          ),
          _seatsType(widget.data, widget.model.seatclass.toString()),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Column _seatsType(List<SeatModel> seats, String seatsType) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
              color: AppConstraint.mainColor,
              borderRadius: BorderRadius.circular(40)),
          child: Text(
            seatsType.toUpperCase(),
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Wrap(
              children: seats.map((e) {
            double margin = 10;
            if (e.sCode!.contains('C')) {
              margin = 40;
            }
            return InkWell(
                onTap: () => __onChooseSeats(e),
                child: e.bStatus == true
                    ? Container(
                        margin: EdgeInsets.only(right: margin, bottom: 10),
                        height: MediaQuery.sizeOf(context).width / 10,
                        width: MediaQuery.sizeOf(context).width / 10,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            e.sCode!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : lstSelected.contains(e)
                        ? Container(
                            margin: EdgeInsets.only(right: margin, bottom: 10),
                            height: MediaQuery.sizeOf(context).width / 10,
                            width: MediaQuery.sizeOf(context).width / 10,
                            decoration: BoxDecoration(
                                color: AppConstraint.mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                e.sCode!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(right: margin, bottom: 10),
                            height: MediaQuery.sizeOf(context).width / 10,
                            width: MediaQuery.sizeOf(context).width / 10,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                e.sCode!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ));
          }).toList()),
        )
      ],
    );
  }

  __onChooseSeats(SeatModel seatsModel) {
    setState(() {
      int passengerTotal = widget.model.adult_amount!.toInt() +
          widget.model.children_amount!.toInt() +
          widget.model.baby_amount!.toInt();

      if (seatsModel.bStatus == false) {
        if (lstSelected.contains(seatsModel)) {
          lstSelected.remove(seatsModel);
        } else {
          if (lstSelected.length < passengerTotal) {
            lstSelected.add(seatsModel);
          }
        }
      }
    });
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
            onTap: () => handleChooseSeats(),
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
        ),
      ],
    );
  }
}
