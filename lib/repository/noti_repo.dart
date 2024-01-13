import 'package:dio/dio.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class NotificationRepository {
  static getNotification(Map<String, dynamic> body) async {
    try {
      final response =
          await ApiService().get(ApiConfig.listNotification, params: body);

      return response['data'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
