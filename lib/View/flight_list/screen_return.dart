// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison, avoid_print, unnecessary_cast, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectsem4/View/choose_seat/choose_seat_screen.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/model/flightinfo_model.dart';
import 'package:projectsem4/model/seat_model.dart';
import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/repository/flight_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:intl/intl.dart';

class FlightListReturnScreen extends StatefulWidget {
  FlightListReturnScreen({
    super.key,
    required this.data,
    required this.model,
  });
  List<FlightModel> data = [];
  BusinessModel model = BusinessModel();
  @override
  State<FlightListReturnScreen> createState() => _FlightListReturnScreenState();
}

class _FlightListReturnScreenState extends State<FlightListReturnScreen> {
  List<AirportModel> lstAir = [];
  List<SeatClassModel> lstClass = [];

  void handleChooseSeat(int id, String timeFrom, String timeTo, String airLine,
      double price) async {
    EasyLoading.show();
    Map<String, dynamic> request = {
      '_fl_id': widget.model.fl_id,
      '_tc_id': widget.model.seatclass_id
    };
    FlightInfoModel response = await FlightRepository.getSeatList(request);
    if (response != null) {
      widget.model.fl_id_return = id;
      widget.model.plane_code = response.sPlCode;
      widget.model.plane_name = response.sPtName;
      widget.model.time_from_return = timeFrom;
      widget.model.time_to_return = timeTo;
      widget.model.airline_return = airLine;
      widget.model.price_return = price;

      Route route = MaterialPageRoute(
          builder: (context) => ChooseSeetScreen(
              model: widget.model, data: response.lFlSeats as List<SeatModel>));

      Navigator.push(context, route);
      EasyLoading.dismiss();
    } else {
      AppConstraint.errorToast("Something wrong in server");
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        backgroundColor: AppConstraint.mainColor,
        title: _flightinfo(context),
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final item = widget.data[index];
          List<String> time =
              formatTime(item.sFlTakeOff as String, item.sFlArrival as String);
          return _flightItem(
              item.iFlId,
              time[1],
              time[2],
              item.sFlFromAbbreviation,
              item.sFlToAbbreviation,
              widget.model.seatclass.toString(),
              item.iSellPrice,
              item.sCarName,
              time[0]);
        },
      ),
    );
  }

  Container _flightItem(
      id, timeFrom, timeTo, from, to, seatClass, price, airlines, flightTime) {
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(price);
    return Container(
        decoration: BoxDecoration(
            color: AppConstraint.colorSlogan,
            border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
        height: 120,
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => handleChooseSeat(id, timeFrom, timeTo, airlines, price),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/image/logo-airline.png', width: 35),
                    const SizedBox(width: 10),
                    Column(children: [
                      Text(
                        timeFrom,
                        style: const TextStyle(
                            fontFamily: AppConstraint.fontFamilyBold,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                      Text(
                        from,
                        style: const TextStyle(fontSize: 17, letterSpacing: 2),
                      )
                    ]),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Image.asset('assets/image/arrow.png',
                            width: 60, height: 25, fit: BoxFit.fill),
                        Text(flightTime,
                            style: const TextStyle(
                                color: AppConstraint.colorLabel, fontSize: 11))
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(children: [
                      Text(
                        timeTo,
                        style: const TextStyle(
                            fontFamily: AppConstraint.fontFamilyBold,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                      Text(
                        to,
                        style: const TextStyle(fontSize: 17, letterSpacing: 2),
                      )
                    ]),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Text(seatClass,
                            style: const TextStyle(
                                color: AppConstraint.colorLabel, fontSize: 12)),
                        Text('$priced đ',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 217, 111, 104),
                                fontFamily: AppConstraint.fontFamilyBold,
                                fontSize: 18))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text("Operated by $airlines",
                  style: const TextStyle(color: AppConstraint.colorLabel))
            ],
          ),
        ));
  }

  InkWell _flightinfo(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                widget.model.airport_to_code.toString(),
                style: const TextStyle(
                    fontFamily: AppConstraint.fontFamilyBold,
                    fontSize: 27,
                    color: Colors.white),
              ),
              Text(
                widget.model.country_to_name.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
          const SizedBox(width: 2),
          const Icon(Icons.arrow_right_alt, color: Colors.white),
          const SizedBox(width: 2),
          Column(
            children: [
              Text(widget.model.airport_from_code.toString(),
                  style: const TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold,
                      fontSize: 27,
                      color: Colors.white)),
              Text(widget.model.country_from_name.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.white))
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                  DateFormat.yMMMEd().format(
                      DateTime.parse(widget.model.return_date as String)),
                  style: const TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold,
                      fontSize: 20,
                      color: Colors.white)),
              Text(
                  widget.model.adult_amount.toString() +
                      ' Adult, ' +
                      widget.model.children_amount.toString() +
                      " Children, " +
                      widget.model.baby_amount.toString() +
                      ' Baby',
                  style: const TextStyle(fontSize: 12, color: Colors.white))
            ],
          )
        ],
      ),
    );
  }

  List<String> formatTime(String time_from, String time_to) {
    DateFormat dateFormat = DateFormat("HH:mm");
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    DateTime timeFromFormat = inputFormat.parse(time_from as String);
    DateTime timeToFormat = inputFormat.parse(time_to as String);
    Duration difference = timeToFormat.difference(timeFromFormat);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    String formattedResult = "${hours}h${minutes}m";
    String timeFrom = dateFormat.format(DateTime.parse(time_from));
    String timeTo = dateFormat.format(DateTime.parse(time_to as String));
    return [formattedResult, timeFrom, timeTo];
  }
}
