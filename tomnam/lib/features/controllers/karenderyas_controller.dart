import 'package:tomnam/models/karenderya.dart';

import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class KarenderyasController {
  static final _logger = Logger();

  static Future<List<Karenderya>> read(
      String? karenderyaId,
      String? karenderyaName,
      String? locationStreet,
      String? locationBarangay,
      String? locationCity,
      String? locationProvince) async {
    final params = <String, String>{};

    if (karenderyaId != null) params['karenderyaId'] = karenderyaId!;
    if (karenderyaName != null) params['Name'] = karenderyaName!;
    if (locationStreet != null) params['locationStreet'] = locationStreet!;
    if (locationBarangay != null) params['locationBarangay'] = locationBarangay!;
    if (locationCity != null) params['locationCity'] = locationCity!;
    if (locationProvince != null) params['locationProvince'] = locationProvince!;
    String url = "/karenderyas";

    if (params.isNotEmpty) {
      url += '?${params.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }

    try {
      final response = await ApiService.getData(url);

      if (response['data'] == null) {
        return [];
      }
      final data = response['data'] as List;
      _logger.d("Data: $data");
      return data
          .map((item) => Karenderya.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e("Error fetching Karenderyas: $e");
      throw Exception("Failed to fetch Karenderyas");
    }
  }
}
