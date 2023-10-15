import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/model/flightinfo_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class FlightRepository {
  static getFlight(Map<String, dynamic> body) async {
    List<FlightModel> flightLst = [];

    try {
      final response = await ApiService().get(ApiConfig.flight, params: body);
      if (response['data'].length != 0) {
        for (var item in response['data']) {
          flightLst.add(FlightModel.fromJson(item));
        }
        return flightLst;
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static getSeatList(Map<String, dynamic> body) async {
    try {
      final response =
          await ApiService().get(ApiConfig.flightinfo, params: body);
      if (response != null) {
        final data = FlightInfoModel.fromJson(response['data']);
        return data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
