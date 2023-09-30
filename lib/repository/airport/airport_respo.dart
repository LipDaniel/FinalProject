import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class AirPortRepository {
  static getAirPort() async {
    List<AirportModel> lstAir = [];
    try {
      final respone = await ApiService().get(ApiConfig.airPort);

      for (var item in respone['data']) {
        lstAir.add(AirportModel.fromJson(item));
      }
      return lstAir;
    } catch (e) {
      throw Exception(e);
    }
  }
}
