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
  String? sCtName;
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
      this.sCtName,
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
    sCtName = json['_ct_name'];
    nBackground = json['_background'];
    sField = json['_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_ap_id'] = iApId;
    data['_ap_index'] = iApIndex;
    data['_ap_name'] = sApName;
    data['_ap_background'] = nApBackground;
    data['_ap_city_id'] = iApCityId;
    data['_ap_icon'] = sApIcon;
    data['_ap_created_date'] = sApCreatedDate;
    data['_ap_updated_date'] = sApUpdatedDate;
    data['_ap_abbreviation'] = sApAbbreviation;
    data['_ap_status'] = bApStatus;
    data['_city_id'] = iCityId;
    data['_city_name'] = sCityName;
    data['_city_status'] = bCityStatus;
    data['_ap_full_name'] = sApFullName;
    data['_ct_name'] = sCtName;
    data['_background'] = nBackground;
    data['_field'] = sField;
    return data;
  }

}
