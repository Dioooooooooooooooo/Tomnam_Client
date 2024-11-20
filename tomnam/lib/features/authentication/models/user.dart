// user.dart
import 'dart:convert';

class User {
  final String email;
  final String token;

  User({required this.email, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'];
    if (accessToken == null) {
      throw const FormatException('Access token is missing in the response');
    }

    try {
      // Parse the JWT payload
      final parts = accessToken.split('.');
      if (parts.length != 3) {
        throw const FormatException('Invalid JWT token format');
      }

      // Decode the payload (part 1)
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final payloadJson = utf8.decode(base64Url.decode(normalized));
      final payloadMap = jsonDecode(payloadJson) as Map<String, dynamic>;

      // Extract user info from the "User" claim
      final userInfo = jsonDecode(payloadMap['User']) as Map<String, dynamic>;

      return User(
        email: userInfo['Email'],
        token: accessToken,
      );
    } catch (e) {
      throw FormatException('Failed to parse user info from token: $e');
    }
  }
}
