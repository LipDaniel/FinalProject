import 'package:dio/dio.dart';
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

  static deleteNotification(Map<String, dynamic> body) async {
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
      );
      final response = await ApiService()
          .post(ApiConfig.deleteNotification, body: body, options: options);
      if(response['isSuccess']){
        return response['isSuccess'];
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }
}
