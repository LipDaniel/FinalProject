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
}