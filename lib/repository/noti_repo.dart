import 'package:dio/dio.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class NotificationRepository {
  static getNotification(Map<String, dynamic> body) async {
    List<FlightModel> flightLst = [];

    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
      );
      final response = await ApiService()
          .get(ApiConfig.listNotification, params: body, options: options);
      if (response['data'].length != 0) {
        return flightLst;
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
