import 'package:flutter/material.dart';
import '../../../data/services/api_service.dart';
import '../models/user.dart';
import 'package:logger/logger.dart';

class LoginController {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<User?> login(String email, String password) async {
    try {
      final loginData = {'email': email, 'password': password};
      final response = await ApiService.postData(loginData);

      if (response['accessToken'] != null) {
        return User.fromJson(response); // Convert response to User model
      }
    } catch (e, stackTrace) {
      _logger.e("Login error for email: $email", e, stackTrace);
    }
    return null;
  }

  Future<void> handleLogin(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter email and password')),
        );
      }
      return;
    }

    final user = await login(email, password);

    if (context.mounted) {
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed!')),
        );
      }
    }
  }
}
