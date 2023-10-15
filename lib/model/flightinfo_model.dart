import 'package:projectsem4/model/seat_model.dart';

class FlightInfoModel {
  int? iFlId;
  int? iFlFromId;
  int? iFlToId;
  String? sFlTakeOff;
  String? sFlArrival;
  String? sCarIcon;
  String? sPlCode;
  String? sPtName;
  List<SeatModel>? lFlSeats;

  FlightInfoModel(
      {this.iFlId,
      this.iFlFromId,
      this.iFlToId,
      this.sFlTakeOff,
      this.sFlArrival,
      this.sCarIcon,
      this.sPlCode,
      this.sPtName,
      this.lFlSeats});

  FlightInfoModel.fromJson(Map<String, dynamic> json) {
    iFlId = json['_fl_id'];
    iFlFromId = json['_fl_from_id'];
    iFlToId = json['_fl_to_id'];
    sFlTakeOff = json['_fl_take_off'];
    sFlArrival = json['_fl_arrival'];
    sCarIcon = json['_car_icon'];
    sPlCode = json['_pl_code'];
    sPtName = json['_pt_name'];
    if (json['_fl_seats'] != null) {
      lFlSeats = <SeatModel>[];
      json['_fl_seats'].forEach((v) {
        lFlSeats!.add(SeatModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_fl_id'] = iFlId;
    data['_fl_from_id'] = iFlFromId;
    data['_fl_to_id'] = iFlToId;
    data['_fl_take_off'] = sFlTakeOff;
    data['_fl_arrival'] = sFlArrival;
    data['_car_icon'] = sCarIcon;
    data['_pl_code'] = sPlCode;
    data['_pt_name'] = sPtName;
    if (lFlSeats != null) {
      data['_fl_seats'] = lFlSeats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
