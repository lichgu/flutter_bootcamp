import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri url;

  NetworkHelper({required this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Something went wrong ($response.statusCode)');
    }
  }
}
