import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';
import '../../models/reservation.dart';

class CalendarController {
  static final _logger = Logger();

  static Future<List<Reservation>> fetchReservations() async {
    String url = "/reservation";

    try {
      final response = await ApiService.getData(url);
      _logger.e(response);

      // Parse the response to get the list of reservations
      List<dynamic> data = response['data'];
      return data.map((item) => Reservation.fromJson(item)).toList();
    } catch (e, stackTrace) {
      _logger.e("Error fetching reservations: $e");
      _logger.e(stackTrace);
      throw Exception("Failed to fetch reservations");
    }
  }
}
