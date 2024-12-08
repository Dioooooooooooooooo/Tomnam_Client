import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/api_service.dart';
import '../../models/user.dart';
import 'package:logger/logger.dart';

class AuthController {
  final _logger = Logger();

  Future<String> register(Map<String, String> registerData) async {
    final response = await ApiService.postData("/auth/register", registerData);

    final data = response['data'];
    _logger.d('Registration successful: $data');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data['token']);

    return response['message'];
  }

  Future<User?> login(String email, String password) async {
    final loginData = {'email': email, 'password': password};
    final response = await ApiService.postData("/auth/login", loginData);

    final data = response['data'];
    _logger.d('Login successful: $data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data['token']);

    final profileRequest = await ApiService.getData("/users/profile");
    final profileData = profileRequest['data'];

    _logger.d(profileData);
    User profile = User(
        Id: profileData['id'],
        email: email,
        role: profileData['role'],
        firstName: profileData['firstName'],
        lastName: profileData['lastName']);

    _logger.d(profile);

    if (profile.role == "Customer") {
      profile.behaviorScore = profileData['behaviorScore'];
    } else {
      profile.karenderyaId = profileData['karenderyaId'];
    }

    prefs.setString('user', jsonEncode(profileData));

    return profile;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('user');
  }
}
