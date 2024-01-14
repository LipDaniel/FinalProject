// ignore_for_file: unnecessary_this, prefer_collection_literals

class NotificationModel {
  int? iNotiId;
  int? iNotiCusId;
  int? iNotiFlId;
  String? sNotiDescription;
  int? iNotiType;
  int? iNotiStatus;
  int? iNotiStt;

  NotificationModel(
      {this.iNotiId,
      this.iNotiCusId,
      this.iNotiFlId,
      this.sNotiDescription,
      this.iNotiType,
      this.iNotiStatus,
      this.iNotiStt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    iNotiId = json['_noti_id'];
    iNotiCusId = json['_noti_cus_id'];
    iNotiFlId = json['_noti_fl_id'];
    sNotiDescription = json['_noti_description'];
    iNotiType = json['_noti_type'];
    iNotiStatus = json['_noti_status'];
    iNotiStt = json['_noti_stt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_noti_id'] = this.iNotiId;
    data['_noti_cus_id'] = this.iNotiCusId;
    data['_noti_fl_id'] = this.iNotiFlId;
    data['_noti_description'] = this.sNotiDescription;
    data['_noti_type'] = this.iNotiType;
    data['_noti_status'] = this.iNotiStatus;
    data['_noti_stt'] = this.iNotiStt;
    return data;
  }
}
