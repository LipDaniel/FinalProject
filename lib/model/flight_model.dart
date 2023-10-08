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
  int? iSellPrice;
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
    data['_fl_id'] = this.iFlId;
    data['_fl_from_id'] = this.iFlFromId;
    data['_fl_to_id'] = this.iFlToId;
    data['_fl_estimate_take_off'] = this.sFlEstimateTakeOff;
    data['_fl_estimate_arrival'] = this.sFlEstimateArrival;
    data['_fl_take_off'] = this.sFlTakeOff;
    data['_fl_arrival'] = this.sFlArrival;
    data['_car_id'] = this.iCarId;
    data['_car_name'] = this.sCarName;
    data['_car_icon'] = this.nCarIcon;
    data['_pl_code'] = this.nPlCode;
    data['_fl_from_name'] = this.sFlFromName;
    data['_fl_to_name'] = this.sFlToName;
    data['_fl_from_abbreviation'] = this.sFlFromAbbreviation;
    data['_fl_to_abbreviation'] = this.sFlToAbbreviation;
    data['_fl_return_date'] = this.nFlReturnDate;
    data['_sell_price'] = this.iSellPrice;
    data['_tc_id'] = this.iTcId;
    data['_fl_estimate'] = this.sFlEstimate;
    return data;
  }
}
