import 'package:flutter/material.dart';

class AppColors {
  static const Color mainGreenColor = Color(0xFF015B55);
  static const Color secondMainGreenColor = Color(0xFF008D71);
  static const Color mainOrangeColor = Color(0xFFF6A747);
  static const Gradient gradientGreenColor = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [
      Color(0xFF008D71),
      Color(0xFF015B55),
    ],
  );
  static const Color accentGreenColor = Color(0xFFA2E5CC);
  static const Color accentOrangeColor = Color(0xFFFFDAB1);
  static const Color accentRedOrangeColor = Color(0xFFFE724C);
  static const Color blackColor = Color(0xFF272827);
  static const Color grayColor = Color(0xFFD7D7D7);
  static const Color whiteColor = Color(0xFFFFFFFF);
}
