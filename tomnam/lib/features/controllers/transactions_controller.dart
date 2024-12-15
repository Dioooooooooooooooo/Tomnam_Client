import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomnam/models/transaction.dart';
import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class TransactionsController {
  static final _logger = Logger();

  static Future<String> confirm(Map<String, String> requestData) async {
    final response = await ApiService.postData("/transaction", requestData);

    final responseData = response['data'];
    _logger.d(responseData);
    _logger.d('Registration successful: $responseData');

    return response['message'];
  }

  Future<List<Transaction>> getAllCustomerTransactions() async {
    final response = await ApiService.getData("/transaction");

    final responseData = response['data'];
    _logger.d(responseData);
    _logger.d('Registration successful: $responseData');

    return List<Transaction>.from(
        responseData.map((x) => Transaction.fromJson(x)));
  }
}
