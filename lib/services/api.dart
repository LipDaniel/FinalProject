import 'package:http/http.dart' as http;
import 'package:projectsem4/ulits/constraint.dart';

class ApiRequest {

  fetchApi(String api) async {
    final response = await http.get(Uri.parse('${AppConstraint.baseUrl}api'));
    if (response.statusCode == 200){
      return response.body;
    }else {
      throw Exception('Something went wrong in server');
    }
  }

  // Future<Album> fetchAlbum() async {
  //   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Album.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }
}


