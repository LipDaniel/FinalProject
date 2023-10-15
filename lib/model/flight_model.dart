class FlightModel {
  int? iFlId;
  int? iFlFromId;
  int? iFlToId;
  String? sFlEstimateTakeOff;
  String? sFlEstimateArrival;
  String? sFlTakeOff;
  String? sFlArrival;
  int? iCarId;
  String? sCarName;
  dynamic nCarIcon;
  dynamic nPlCode;
  String? sFlFromName;
  String? sFlToName;
  String? sFlFromAbbreviation;
  String? sFlToAbbreviation;
  dynamic nFlReturnDate;
  double? iSellPrice;
  int? iTcId;
  String? sFlEstimate;

  FlightModel(
      {this.iFlId,
      this.iFlFromId,
      this.iFlToId,
      this.sFlEstimateTakeOff,
      this.sFlEstimateArrival,
      this.sFlTakeOff,
      this.sFlArrival,
      this.iCarId,
      this.sCarName,
      this.nCarIcon,
      this.nPlCode,
      this.sFlFromName,
      this.sFlToName,
      this.sFlFromAbbreviation,
      this.sFlToAbbreviation,
      this.nFlReturnDate,
      this.iSellPrice,
      this.iTcId,
      this.sFlEstimate});

  FlightModel.fromJson(Map<String, dynamic> json) {
    iFlId = json['_fl_id'];
    iFlFromId = json['_fl_from_id'];
    iFlToId = json['_fl_to_id'];
    sFlEstimateTakeOff = json['_fl_estimate_take_off'];
    sFlEstimateArrival = json['_fl_estimate_arrival'];
    sFlTakeOff = json['_fl_take_off'];
    sFlArrival = json['_fl_arrival'];
    iCarId = json['_car_id'];
    sCarName = json['_car_name'];
    nCarIcon = json['_car_icon'];
    nPlCode = json['_pl_code'];
    sFlFromName = json['_fl_from_name'];
    sFlToName = json['_fl_to_name'];
    sFlFromAbbreviation = json['_fl_from_abbreviation'];
    sFlToAbbreviation = json['_fl_to_abbreviation'];
    nFlReturnDate = json['_fl_return_date'];
    iSellPrice = json['_sell_price'];
    iTcId = json['_tc_id'];
    sFlEstimate = json['_fl_estimate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_fl_id'] = iFlId;
    data['_fl_from_id'] = iFlFromId;
    data['_fl_to_id'] = iFlToId;
    data['_fl_estimate_take_off'] = sFlEstimateTakeOff;
    data['_fl_estimate_arrival'] = sFlEstimateArrival;
    data['_fl_take_off'] = sFlTakeOff;
    data['_fl_arrival'] = sFlArrival;
    data['_car_id'] = iCarId;
    data['_car_name'] = sCarName;
    data['_car_icon'] = nCarIcon;
    data['_pl_code'] = nPlCode;
    data['_fl_from_name'] = sFlFromName;
    data['_fl_to_name'] = sFlToName;
    data['_fl_from_abbreviation'] = sFlFromAbbreviation;
    data['_fl_to_abbreviation'] = sFlToAbbreviation;
    data['_fl_return_date'] = nFlReturnDate;
    data['_sell_price'] = iSellPrice;
    data['_tc_id'] = iTcId;
    data['_fl_estimate'] = sFlEstimate;
    return data;
  }
}
