import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl = "your_base_url_here"; // Replace with your actual base URL

  static Future<http.Response> get(String endpoint) async {
    final url = '$_baseUrl$endpoint';
    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$_baseUrl$endpoint';
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final url = '$_baseUrl$endpoint';
    return await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> delete(String endpoint) async {
    final url = '$_baseUrl$endpoint';
    return await http.delete(Uri.parse(url));
  }

  static void handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Success: ${jsonDecode(response.body)}');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Failed to load data: ${response.statusCode}');
    }
  }
}
