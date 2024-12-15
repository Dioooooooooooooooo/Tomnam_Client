import '../../data/services/api_service.dart';
import 'package:tomnam/models/cart_item.dart';
import 'package:logger/logger.dart';

class ReservationController {
  static final _logger = Logger();

  static Future<String> create(Map<String, dynamic> data) async {
    String url = "/reservation";

    try {
      final response = await ApiService.postData(url, data);

      final responseData = response['data'] as Map<String, dynamic>;
      _logger.d('responseDate $responseData');
      return response['message'];
    } catch (e, stackTrace) {
      _logger.e("Error creating reservation: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to create reservation");
    }
  }
}
