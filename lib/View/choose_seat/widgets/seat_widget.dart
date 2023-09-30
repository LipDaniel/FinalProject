import 'package:flutter/material.dart';
import 'package:projectsem4/model/seat_model.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:projectsem4/ulits/enum_app.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget({super.key});

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  SeatsModel? seatSelected;
  List<SeatsModel> lstSelected = [];
  List<SeatsModel> lstDisable = [];

  @override
  void initState() {
    lstDisable = [
      const SeatsModel(id: 'A1'),
      const SeatsModel(id: 'A3'),
      const SeatsModel(id: 'A4'),
      const SeatsModel(id: 'B7'),
      const SeatsModel(id: 'C2'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Vietnam Airlines',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          _seatsType(firtClass, SeatsType.firtClass),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Column _seatsType(List<SeatsModel> seats, SeatsType seatsType) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
              color: AppConstraint.mainColor,
              borderRadius: BorderRadius.circular(40)),
          child: Text(
            seatsType.value.toUpperCase(),
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
              children: seats.asMap().entries.map((e) {
            int index = e.key;
            List<int> lstIndex = [2];
            double paddingRight;
            for (int i = 2; i < seats.length; i++) {
              if (i > 8) {
                i += 5;
              } else {
                i += 6;
              }
              lstIndex.add(i);
            }
            if (lstIndex.contains(index)) {
              paddingRight = 50;
            } else {
              paddingRight = 10;
            }
            return InkWell(
                onTap: () => __onChooseSeats(e.value),
                child: lstDisable.contains(e.value)
                    ? Container(
                        margin:
                            EdgeInsets.only(right: paddingRight, bottom: 10),
                        height: MediaQuery.sizeOf(context).width / 10,
                        width: MediaQuery.sizeOf(context).width / 10,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            e.value.id!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : lstSelected.contains(e.value)
                        ? Container(
                            margin: EdgeInsets.only(
                                right: paddingRight, bottom: 10),
                            height: MediaQuery.sizeOf(context).width / 10,
                            width: MediaQuery.sizeOf(context).width / 10,
                            decoration: BoxDecoration(
                                color: AppConstraint.mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                e.value.id!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                right: paddingRight, bottom: 10),
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
                                e.value.id!,
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

  __onChooseSeats(SeatsModel seatsModel) {
    setState(() {
      if (!lstDisable.contains(seatsModel)) {
        if (lstSelected.contains(seatsModel)) {
          lstSelected.remove(seatsModel);
        } else {
          lstSelected.add(seatsModel);
        }
      }
    });
  }
}
