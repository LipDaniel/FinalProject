import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class AuthenticateRepository {
  static register(Map<String, dynamic> body) async {
    // List<FlightModel> flightLst = [];

    try {
      final response = await ApiService().post(ApiConfig.register, body: body);
      return response;
      // if (response['isSuccess'] == true) {
      //   return flightLst;
      // } else {
      //   return response['data'];
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  static login(Map<String, dynamic> body) async {
    try{
      final response = await ApiService().post(ApiConfig.login, body: body);
      return response;
      // if (response['isSuccess'] == true) {
      //   return flightLst;
      // } else {
      //   return response['data'];
      // }
    } catch (e) {
      throw Exception(e);
    }
  }
}
