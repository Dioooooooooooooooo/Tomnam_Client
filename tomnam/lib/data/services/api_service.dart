import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomnam/Exceptions/response_exception.dart';

class ApiService {
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );
  static const String baseUrl = 'http://192.168.254.104:5144/api';

  // GET request example with token
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken'); // Retrieve token

      String url = baseUrl + endpoint;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // POST request example with token
  static Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
      _logger.d(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken'); // Retrieve token

    String url = baseUrl + endpoint;
  
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    final body = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return body;
    } else {
      String message = body['message'];
      String error = body['error'];
      throw ResponseException(message, error, response.statusCode);
    }
  }
}