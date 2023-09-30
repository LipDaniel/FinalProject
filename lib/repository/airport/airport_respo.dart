import 'package:dio/dio.dart';
import 'package:projectsem4/services/api_config.dart';

class AirPortRepository {
  Future<dynamic> getAirPort() async {
    try {
      final respone = await Dio().get(ApiConfig.airPort);

      print(respone);
    } catch (e) {
      print(e);
    }
  }
}
