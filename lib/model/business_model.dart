// ignore_for_file: non_constant_identifier_names

import 'package:projectsem4/model/passenger_model.dart';

class BusinessModel {
  int? fl_id;
  int? airport_from_id;
  int? airport_to_id;
  int? adult_amount;
  int? children_amount;
  int? baby_amount;
  String? depart_date;
  int? seatclass_id;
  String? country_to_name;
  String? airport_to_code;
  String? country_from_name;
  String? airport_from_code;
  String? return_date;
  String? seatclass;
  double? price;
  bool? isRoundTrip;
  List<String>? seatList;
  List<String>? seatList_return;
  String? plane_code;
  String? plane_name;
  String? time_to;
  String? time_from;
  String? airline;
  List<PassengerModel>? passenger_list;

  BusinessModel(
      {this.fl_id,
      this.airport_from_id,
      this.price,
      this.airport_from_code,
      this.country_from_name,
      this.airport_to_id,
      this.airport_to_code,
      this.country_to_name,
      this.adult_amount,
      this.children_amount,
      this.baby_amount,
      this.depart_date,
      this.return_date,
      this.seatclass_id,
      this.seatclass,
      this.plane_code,
      this.plane_name,
      this.airline,
      this.isRoundTrip,
      this.seatList,
      this.seatList_return,
      this.passenger_list});
}
