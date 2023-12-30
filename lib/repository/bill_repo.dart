import 'package:dio/dio.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class BillRepository {
  static insertBill(Map<String, dynamic> body) async {
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
      );
      final response = await ApiService()
          .post(ApiConfig.insertbill, body: body, options: options);

      if (response != null) {
        if (response['isSuccess'] == true) {
          return "Create ticket successfully";
        } else {
          return response['mes'];
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
