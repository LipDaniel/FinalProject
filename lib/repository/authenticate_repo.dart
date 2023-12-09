import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class AuthenticateRepository {
  static getFlight(Map<String, dynamic> body) async {
    // List<FlightModel> flightLst = [];

    try {
      final response = await ApiService().get(ApiConfig.register, params: body);
      return response;
      // if (response['data'].length != 0) {
      //   for (var item in response['data']) {
      //     flightLst.add(FlightModel.fromJson(item));
      //   }
      //   return flightLst;
      // } else {
      //   return response['data'];
      // }
    } catch (e) {
      throw Exception(e);
    }
  }
}
