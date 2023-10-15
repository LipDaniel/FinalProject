class BusinessModel {
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

  String? plane_code;
  String? plane_name;
  String? time_to;
  String? time_from;
  String? airline;

  BusinessModel(
    {this.airport_from_id,
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
    this.airline});
}
