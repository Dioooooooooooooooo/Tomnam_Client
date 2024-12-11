import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomnam/Exceptions/response_exception.dart';

class ApiService {
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );
  static const String baseURL = 'http://192.168.43.44:5144';
  static const String apiURL = '$baseURL/api';

  // GET request example with token
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken'); // Retrieve token

      String url = apiURL + endpoint;

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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken'); // Retrieve token

      String url = apiURL + endpoint;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      );

      final body = json.decode(response.body);
      _logger.d(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        String message = body['message'];

        String error;
        if (body['error'] is List<dynamic>) {
          error = (body['error'] as List).join(" ");
        } else {
          error = body['error'];
        }

        _logger.e(message);
        _logger.e(error);
        throw ResponseException(message, error, response.statusCode);
      }
    } catch (e, stackTrace) {
      _logger.e(stackTrace);
      _logger.e('Error in postData: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> putData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken'); // Retrieve token

      String url = apiURL + endpoint;

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      );

      final body = json.decode(response.body);
      _logger.d(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        String message = body['message'];
        String error = body['error'];
        _logger.e(message);
        _logger.e(error);
        throw ResponseException(message, error, response.statusCode);
      }
    } catch (e, stackTrace) {
      _logger.e(stackTrace);
      _logger.e('Error in putData: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> postMultipartData({
    required String endpoint,
    required Map<String, String> fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      String url = apiURL + endpoint;

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Authorization'] = 'Bearer $token';

      request.fields.addAll(fields);

      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final body = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        String message = body['message'] ?? 'An error occurred';
        String error = body['error'] ?? 'Unknown error';
        throw ResponseException(message, error, response.statusCode);
      }
    } catch (e) {
      _logger.e('Error in postMultipartData: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> putMultipartData({
    required String endpoint,
    required Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      String url = apiURL + endpoint;

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers['Authorization'] = 'Bearer $token';

      request.fields.addAll(fields!);

      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final body = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        String message = body['message'] ?? 'An error occurred';
        String error = body['error'] ?? 'Unknown error';
        throw ResponseException(message, error, response.statusCode);
      }
    } catch (e) {
      _logger.e('Error in postMultipartData: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> deleteData(String endpoint) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken'); // Retrieve token

      String url = apiURL + endpoint;

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = json.decode(response.body);
      _logger.d(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        String message = body['message'];

        String error;
        if (body['error'] is List<dynamic>) {
          error = (body['error'] as List).join(" ");
        } else {
          error = body['error'];
        }

        _logger.e(message);
        _logger.e(error);
        throw ResponseException(message, error, response.statusCode);
      }
    } catch (e, stackTrace) {
      _logger.e(stackTrace);
      _logger.e('Error in delete: $e');
      rethrow;
    }
  }
}
