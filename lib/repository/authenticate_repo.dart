import 'package:dio/dio.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class AuthenticateRepository {
  static register(Map<String, dynamic> body) async {
    try {
      final response = await ApiService().post(ApiConfig.register, body: body);
      if (response['data'] == null) {
        return response['mes'];
      } else {
        return "Success";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static login(Map<String, dynamic> body) async {
    try {
      final response = await ApiService().post(ApiConfig.login, body: body);
      if (response['data'] == null) {
        return false;
      }
      return response['data'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static updateProfile(Map<String, dynamic> body) async {
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
      );
      final response = await ApiService()
          .post(ApiConfig.updateProfile, body: body, options: options);
      if (response['data'] == null) {
        return "Something wrong in server";
      }
      return response['data'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
