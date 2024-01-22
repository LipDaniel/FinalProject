// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class TicketsModel {
  int? iBilId;
  double? iBilPayment;
  List<Tickets>? lTickets;

  TicketsModel({this.iBilId, this.iBilPayment, this.lTickets});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    iBilId = json['_bil_id'];
    iBilPayment = json['_bil_payment'];
    if (json['_tickets'] != null) {
      lTickets = <Tickets>[];
      json['_tickets'].forEach((v) {
        lTickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_bil_id'] = this.iBilId;
    data['_bil_payment'] = this.iBilPayment;
    if (this.lTickets != null) {
      data['_tickets'] = this.lTickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BilFlight {
  String? sFlTakeOff;
  String? sFlArrival;
  String? sCtFromName;
  String? sCtToName;
  String? sCarName;
  String? sPlCode;
  String? sFlFromName;
  String? sFlToName;
  String? sFlFromAbbreviation;
  String? sFlToAbbreviation;
  dynamic nFlReturnDate;
  String? sPtName;
  String? sTcName;

  BilFlight(
      {this.sFlTakeOff,
      this.sFlArrival,
      this.sCtFromName,
      this.sCtToName,
      this.sCarName,
      this.sPlCode,
      this.sFlFromName,
      this.sFlToName,
      this.sFlFromAbbreviation,
      this.sFlToAbbreviation,
      this.nFlReturnDate,
      this.sPtName,
      this.sTcName});

  BilFlight.fromJson(Map<String, dynamic> json) {
    sFlTakeOff = json['_fl_take_off'];
    sFlArrival = json['_fl_arrival'];
    sCtFromName = json['_ct_from_name'];
    sCtToName = json['_ct_to_name'];
    sCarName = json['_car_name'];
    sPlCode = json['_pl_code'];
    sFlFromName = json['_fl_from_name'];
    sFlToName = json['_fl_to_name'];
    sFlFromAbbreviation = json['_fl_from_abbreviation'];
    sFlToAbbreviation = json['_fl_to_abbreviation'];
    nFlReturnDate = json['_fl_return_date'];
    sPtName = json['_pt_name'];
    sTcName = json['_tc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_fl_take_off'] = this.sFlTakeOff;
    data['_fl_arrival'] = this.sFlArrival;
    data['_ct_from_name'] = this.sCtFromName;
    data['_ct_to_name'] = this.sCtToName;
    data['_car_name'] = this.sCarName;
    data['_pl_code'] = this.sPlCode;
    data['_fl_from_name'] = this.sFlFromName;
    data['_fl_to_name'] = this.sFlToName;
    data['_fl_from_abbreviation'] = this.sFlFromAbbreviation;
    data['_fl_to_abbreviation'] = this.sFlToAbbreviation;
    data['_fl_return_date'] = this.nFlReturnDate;
    data['_pt_name'] = this.sPtName;
    data['_tc_name'] = this.sTcName;
    return data;
  }
}

class Tickets {
  String? sTkFullName;
  String? sTkTitle;
  int? sTkFlightId;
  dynamic nTkDob;
  double? sTkPayment;
  int? iTkGate;
  String? sTkSeat;
  BilFlight? bBilFlight;
  int? iTkCabin;
  int? iTkChecked;

  Tickets(
      {this.sTkFullName,
      this.sTkTitle,
      this.nTkDob,
      this.sTkFlightId,
      this.bBilFlight,
      this.iTkGate, 
      this.sTkPayment,
      this.sTkSeat,
      this.iTkCabin,
      this.iTkChecked});

  Tickets.fromJson(Map<String, dynamic> json) {
    sTkFullName = json['_tk_full_name'];
    sTkTitle = json['_tk_title'];
    sTkFlightId = json['_tk_fl_id'];
    sTkPayment = json['_tk_payment'];
    bBilFlight = json['_tk_flight'] != null
        ? new BilFlight.fromJson(json['_tk_flight'])
        : null;
    nTkDob = json['_tk_dob'];
    iTkGate = json['_tk_gate'];
    sTkSeat = json['_tk_seat'];
    iTkCabin = json['_tk_cabin'];
    iTkChecked = json['_tk_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_tk_full_name'] = this.sTkFullName;
    data['_tk_title'] = this.sTkTitle;
    data['_tk_dob'] = this.nTkDob;
    data['_tk_payment'] = this.sTkPayment;
    data['_tk_fl_id'] = this.sTkFlightId;
    data['_tk_gate'] = this.iTkGate;
    data['_tk_seat'] = this.sTkSeat;
    data['_tk_cabin'] = this.iTkCabin;
    data['_tk_checked'] = this.iTkChecked;
    if (this.bBilFlight != null) {
      data['_tk_flight'] = this.bBilFlight!.toJson();
    }
    return data;
  }
}
