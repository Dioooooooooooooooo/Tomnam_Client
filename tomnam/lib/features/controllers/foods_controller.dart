import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/models/user.dart';
import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class FoodsController {
  static final _logger = Logger();

  static Future<List<Food>> read(
      String? foodId, String? foodName, String? karenderyaId) async {
    final params = <String, String>{};
    String url = "/karenderyas/foods";

    if (foodId != null) params['foodId'] = foodId!;
    if (foodName != null) params['foodName'] = foodName!;
    if (karenderyaId != null) params['KarenderyaId'] = karenderyaId!;

    if (params.isNotEmpty) {
      url += '?${params.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }

    _logger.d("Fetching Foods from: $url");

    try {
      final response = await ApiService.getData(url);

      if (response['data'] == null) {
        return [];
      }

      final data = response['data'] as List;
      _logger.d("Data: $data");
      return data
          .map((item) => Food.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      _logger.e("Error fetching Foods: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to fetch Foods");
    }
  }

  static Future<String> create(
      Map<String, String> foodData, File foodPhoto) async {
    // Create a MultipartFile from the file path
    http.MultipartFile file = await http.MultipartFile.fromPath(
      'FoodPhoto', // Name of the field in the backend
      foodPhoto.path,
    );

    User user = await ProfileController.getUser();

    final response = await ApiService.postMultipartData(
        endpoint: "/karenderyas/foods/${user.karenderyaId}",
        fields: foodData,
        files: [file]);

    _logger.d(response['message']);
    return response['message'];
  }

  static Future<String> update(
      String foodId, Map<String, String> foodData, File? foodPhoto) async {
    late http.MultipartFile file;
    if (foodPhoto != null) {
      // Create a MultipartFile from the file path
      file = await http.MultipartFile.fromPath(
        'FoodPhoto', // Name of the field in the backend
        foodPhoto.path,
      );
    }

    var response;

    if (foodPhoto != null) {
      response = await ApiService.putMultipartData(
        endpoint: "/karenderyas/foods/$foodId/update",
        fields: foodData,
        files: [file],
      );
    } else {
      response = await ApiService.putMultipartData(
        endpoint: "/karenderyas/foods/$foodId/update",
        fields: foodData,
        files: null,
      );
    }

    _logger.d(response['message']);

    return response['message'];
  }

  static Future<String> delete(String foodId) async {
    final response = await ApiService.deleteData(
      "/karenderyas/foods/$foodId/delete",
    );

    _logger.d(response['message']);
    return response['message'];
  }
}
