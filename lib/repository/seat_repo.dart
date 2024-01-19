import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class SeatClassRepository {
  static getSeatClass() async {
    List<SeatClassModel> lstSeat = [];
    try {
      final respone = await ApiService().get(ApiConfig.seatClass);

      for (var item in respone['data']) {
        lstSeat.add(SeatClassModel.fromJson(item));
      }
      return lstSeat;
    } catch (e) {
      throw Exception(e);
    }
  }

  static checkSeat(Map<String, dynamic> params) async {
    var tmp = [
      {"id": 0, "_code": "A2"},
    ];
    try {
      final response =
          await ApiService().get(ApiConfig.checkseat, params: params);
      if (response['fail'].isEmpty) {
        return [];
      }
      return response['fail'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
