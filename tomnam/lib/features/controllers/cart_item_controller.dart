import '../../data/services/api_service.dart';
import 'package:tomnam/models/cart_item.dart';
import 'package:logger/logger.dart';

class CartItemController {
  static final _logger = Logger();

  static Future<List<CartItem>> read() async {
    String url = "/cart";

    try {
      final response = await ApiService.getData(url);

      if (response['data'] == null) {
        return [];
      }

      final data = response['data'] as List;
      return data
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      _logger.e("Error fetching Foods: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to fetch Foods");
    }
  }

  static Future<CartItem> update (String id, Map<String, dynamic> data) async {
    String url = "/cart/$id";

    try {
      final response = await ApiService.putData(url, data);

      final responseData = response['data'] as Map<String, dynamic>;
      return CartItem.fromJson(responseData);
    } catch (e, stackTrace) {
      _logger.e("Error updating CartItem: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to update CartItem");
    }
  }

  static Future<CartItem> create (Map<String, dynamic> data) async {
    String url = "/cart";

    try {
      final response = await ApiService.postData(url, data);

      final responseData = response['data'] as Map<String, dynamic>;
      return CartItem.fromJson(responseData);
    } catch (e, stackTrace) {
      _logger.e("Error creating CartItem: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to create CartItem");
    }
  }
}