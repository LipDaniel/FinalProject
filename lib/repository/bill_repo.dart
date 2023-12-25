import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class BillRepository {

  static insertBill(Map<String, dynamic> body) async {
    try {
      final respone = await ApiService().post(ApiConfig.insertbill, body: body);
      return respone;
    } catch (e) {
      throw Exception(e);
    }
  }
}
