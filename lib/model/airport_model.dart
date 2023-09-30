class AirportModel {
  int? iApId;
  int? iApIndex;
  String? sApName;
  dynamic nApBackground;
  int? iApCityId;
  String? sApIcon;
  String? sApCreatedDate;
  String? sApUpdatedDate;
  String? sApAbbreviation;
  bool? bApStatus;
  int? iCityId;
  String? sCityName;
  bool? bCityStatus;
  String? sApFullName;
  dynamic nBackground;
  String? sField;

  AirportModel(
      {this.iApId,
      this.iApIndex,
      this.sApName,
      this.nApBackground,
      this.iApCityId,
      this.sApIcon,
      this.sApCreatedDate,
      this.sApUpdatedDate,
      this.sApAbbreviation,
      this.bApStatus,
      this.iCityId,
      this.sCityName,
      this.bCityStatus,
      this.sApFullName,
      this.nBackground,
      this.sField});

  AirportModel.fromJson(Map<String, dynamic> json) {
    iApId = json['_ap_id'];
    iApIndex = json['_ap_index'];
    sApName = json['_ap_name'];
    nApBackground = json['_ap_background'];
    iApCityId = json['_ap_city_id'];
    sApIcon = json['_ap_icon'];
    sApCreatedDate = json['_ap_created_date'];
    sApUpdatedDate = json['_ap_updated_date'];
    sApAbbreviation = json['_ap_abbreviation'];
    bApStatus = json['_ap_status'];
    iCityId = json['_city_id'];
    sCityName = json['_city_name'];
    bCityStatus = json['_city_status'];
    sApFullName = json['_ap_full_name'];
    nBackground = json['_background'];
    sField = json['_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_ap_id'] = this.iApId;
    data['_ap_index'] = this.iApIndex;
    data['_ap_name'] = this.sApName;
    data['_ap_background'] = this.nApBackground;
    data['_ap_city_id'] = this.iApCityId;
    data['_ap_icon'] = this.sApIcon;
    data['_ap_created_date'] = this.sApCreatedDate;
    data['_ap_updated_date'] = this.sApUpdatedDate;
    data['_ap_abbreviation'] = this.sApAbbreviation;
    data['_ap_status'] = this.bApStatus;
    data['_city_id'] = this.iCityId;
    data['_city_name'] = this.sCityName;
    data['_city_status'] = this.bCityStatus;
    data['_ap_full_name'] = this.sApFullName;
    data['_background'] = this.nBackground;
    data['_field'] = this.sField;
    return data;
  }

  airportAsString(){
    return this.sApFullName;
  }
}
