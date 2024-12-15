import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tomnam/models/karenderya.dart';
import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class KarenderyasController {
  static final _logger = Logger();

  static Future<Karenderya> create(
      Map<String, String> karenderyaDetails) async {
    try {
      _logger.d("Creating Karenderya: $karenderyaDetails");
      final response =
          await ApiService.postData("/karenderyas/create", karenderyaDetails);

      final data = response['data'] as Map<String, dynamic>;
      _logger.d(data);
      var karenderya = Karenderya.fromJson(data);
      return karenderya;
    } catch (e, StackTrace) {
      _logger.e("Error creating Karenderya: $e");
      throw Exception("Failed to create Karenderya");
    }
  }

  static Future<List<Karenderya>> read(
      String? karenderyaId,
      String? karenderyaName,
      String? locationStreet,
      String? locationBarangay,
      String? locationCity,
      String? locationProvince) async {
    final params = <String, String>{};

    if (karenderyaId != null) params['karenderyaId'] = karenderyaId;
    if (karenderyaName != null) params['Name'] = karenderyaName;
    if (locationStreet != null) params['locationStreet'] = locationStreet;
    if (locationBarangay != null) params['locationBarangay'] = locationBarangay;
    if (locationCity != null) params['locationCity'] = locationCity;
    if (locationProvince != null) params['locationProvince'] = locationProvince;
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

  static Future<String> update(
    String karenderyaId,
    String? karenderyaName,
    String? locationStreet,
    String? locationBarangay,
    String? locationCity,
    String? locationProvince,
    String? description,
    File? logoPhoto,
    File? coverPhoto,
  ) async {
    late http.MultipartFile coverFile, logoFile;

    if (coverPhoto != null) {
      coverFile = await http.MultipartFile.fromPath(
        'CoverPhoto', // Name of the field in the backend
        coverPhoto.path,
      );
    }

    if (logoPhoto != null) {
      logoFile = await http.MultipartFile.fromPath(
        'LogoPhoto', // Name of the field in the backend
        logoPhoto.path,
      );
    }

    Map<String, String> bodyFields = <String, String>{};

    if (karenderyaName != null) {
      bodyFields['KarenderyaName'] = karenderyaName;
    }

    if (locationStreet != null) {
      bodyFields['LocationStreet'] = locationStreet;
    }

    if (locationBarangay != null) {
      bodyFields['LocationBarangay'] = locationBarangay;
    }

    if (locationCity != null) {
      bodyFields['LocationCity'] = locationCity;
    }

    if (locationProvince != null) {
      bodyFields['LocationProvince'] = locationProvince;
    }

    if (description != null) {
      bodyFields['Description'] = description;
    }

    String url = '/karenderyas/$karenderyaId/update';

    var response;

    if (coverPhoto != null) {
      _logger.d('updating cover photo');
      response = await ApiService.putMultipartData(
          endpoint: url, fields: null, files: [coverFile]);
    } else if (logoPhoto != null) {
      _logger.d('updating logo photo');
      response = await ApiService.putMultipartData(
          endpoint: url, fields: null, files: [logoFile]);
    } else {
      _logger.d('updating karenderya');
      response = await ApiService.putData(url, bodyFields);
    }

    _logger.d(response['message']);

    return response['message'];
  }
}
