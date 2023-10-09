class BusinessModel {
  int? airport_from_id;
  String? airport_from_code;
  String? country_from_name;
  int? airport_to_id;
  String? airport_to_code;
  String? country_to_name;
  int? adult_amount;
  int? children_amount;
  int? baby_amount;
  String? depart_date;
  String? return_date;
  int? seatclass_id;

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
    this.seatclass_id});
}
