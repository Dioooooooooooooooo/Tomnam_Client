import 'package:flutter/material.dart';
import '../../../data/services/api_service.dart';
import '../models/user.dart';
import 'package:logger/logger.dart';
import '../../../utils/constants/routes.dart';
import 'dart:convert';

class LoginController {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<User?> login(String email, String password) async {
    try {
      final loginData = {'email': email, 'password': password};
      final response = await ApiService.postData(loginData);

      _logger.d('API Response: $response');

      // Check if response has required accessToken
      if (response['accessToken'] != null) {
        return User.fromJson(response);
      } else {
        _logger.w('Invalid response format: $response');
        return null;
      }
    } catch (e, stackTrace) {
      _logger.e('Login error for email: $email', e, stackTrace);
      return null;
    }
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

    try {
      final user = await login(email, password);

      if (!context.mounted) return;

      if (user != null) {
        // Login successful
        Navigator.of(context).pushNamedAndRemoveUntil(
          mainPageRoute,
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: ${e.toString()}')),
      );
    }
  }
}
