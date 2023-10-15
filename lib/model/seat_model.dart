class SeatModel {
  String? sCode;
  int? iIndex;
  String? sClass;
  bool? bStatus;
  int? iClassId;

  SeatModel({this.sCode, this.iIndex, this.sClass, this.bStatus, this.iClassId});

  SeatModel.fromJson(Map<String, dynamic> json) {
    sCode = json['_code'];
    iIndex = json['_index'];
    sClass = json['_class'];
    bStatus = json['_status'];
    iClassId = json['_class_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_code'] = sCode;
    data['_index'] = iIndex;
    data['_class'] = sClass;
    data['_status'] = bStatus;
    data['_class_id'] = iClassId;
    return data;
  }
}
