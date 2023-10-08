import 'package:dio/dio.dart';
import 'package:projectsem4/services/api_config.dart';

class ApiService {
  final dio = Dio();

  ApiService() {
    _setupTimeout();
  }

  _setupTimeout() {
    dio.options.sendTimeout = const Duration(seconds: 30);
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<dynamic> get(String url, {dynamic params, Options? options}) async {
    try {
      var response = await dio.get(ApiConfig.baseUrl + url, queryParameters: params);
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic>? body, Options? options}) async {
    try {
      var response =
          await dio.post(ApiConfig.baseUrl + url, data: body, options: options);

      if (response.statusCode == 200) {
        var data = response.data;

        return data;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
