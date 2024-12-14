import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tomnam/models/karenderya.dart';
import '../../data/services/api_service.dart';
import 'package:logger/logger.dart';

class ProofOfBusinessController {
  static final _logger = Logger();

  static Future<void> create(
      Karenderya karenderya,
      File ownerValidID1,
      File ownerValidID2,
      File businessPermit,
      // ignore: non_constant_identifier_names
      File BIRPermit) async {
    try {
      // Create a MultipartFile from the file path
      http.MultipartFile ownerValidID1File = await http.MultipartFile.fromPath(
        'OwnerValidID1', // Name of the field in the backend
        ownerValidID1.path,
      );

      http.MultipartFile ownerValidID2File = await http.MultipartFile.fromPath(
        'OwnerValidID2', // Name of the field in the backend
        ownerValidID2.path,
      );

      http.MultipartFile businessPermitFile = await http.MultipartFile.fromPath(
        'BusinessPermit', // Name of the field in the backend
        businessPermit.path,
      );

      // ignore: non_constant_identifier_names
      http.MultipartFile BIRPermitFile = await http.MultipartFile.fromPath(
        'BIRPermit', // Name of the field in the backend
        BIRPermit.path,
      );

      final response = await ApiService.postMultipartData(
          endpoint: "/karenderyas/${karenderya.Id}/proof/create",
          fields: {},
          files: [
            ownerValidID2File,
            ownerValidID1File,
            businessPermitFile,
            BIRPermitFile
          ]);

      _logger.d(response['message']);
      return response['message'];
    } catch (e, StackTrace) {
      _logger.e("Error creating Karenderya: $e");
      throw Exception("Failed to create Karenderya");
    }
  }
}
