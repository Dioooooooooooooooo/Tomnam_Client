import 'package:tomnam/models/food.dart';
import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class FoodsController {
  static final _logger = Logger();

  static Future<List<Food>> read(
      String? foodId,
      String? foodName,
      String? karenderyaId
      ) async {
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
}