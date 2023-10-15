class SeatClassModel {
  int? iTcId;
  int? iTcIndex;
  String? sTcName;
  String? sTcIcon;
  String? sTcCreatedDate;
  String? sTcUpdatedDate;
  bool? bTcStatus;
  String? sField;

  SeatClassModel(
      {this.iTcId,
      this.iTcIndex,
      this.sTcName,
      this.sTcIcon,
      this.sTcCreatedDate,
      this.sTcUpdatedDate,
      this.bTcStatus,
      this.sField});

  SeatClassModel.fromJson(Map<String, dynamic> json) {
    iTcId = json['_tc_id'];
    iTcIndex = json['_tc_index'];
    sTcName = json['_tc_name'];
    sTcIcon = json['_tc_icon'];
    sTcCreatedDate = json['_tc_created_date'];
    sTcUpdatedDate = json['_tc_updated_date'];
    bTcStatus = json['_tc_status'];
    sField = json['_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_tc_id'] = iTcId;
    data['_tc_index'] = iTcIndex;
    data['_tc_name'] = sTcName;
    data['_tc_icon'] = sTcIcon;
    data['_tc_created_date'] = sTcCreatedDate;
    data['_tc_updated_date'] = sTcUpdatedDate;
    data['_tc_status'] = bTcStatus;
    data['_field'] = sField;
    return data;
  }
}
