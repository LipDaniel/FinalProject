import 'package:projectsem4/model/notification_model.dart';
import 'package:projectsem4/services/api_config.dart';
import 'package:projectsem4/services/api_service.dart';

class NotificationRepository {
  static getNotification(Map<String, dynamic> body) async {
    List<NotificationModel> notiLst = [];
    try {
      final response =
          await ApiService().get(ApiConfig.listNotification, params: body);
      if (response['data'].length != 0) {
        for (var item in response['data']) {
          notiLst.add(NotificationModel.fromJson(item));
        }
        return notiLst;
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
