import 'package:tomnam/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class ProfileController {
  static final Logger _logger = Logger(printer: PrettyPrinter());

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');

    _logger.d(userPref);

    Map<String, dynamic> userMap =
        jsonDecode(userPref!) as Map<String, dynamic>;
    return User.fromJson(userMap);
  }
}
