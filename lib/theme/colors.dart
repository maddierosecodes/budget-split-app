import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor green = MaterialColor(
    0xFF158F00, // Base
    {
      50: Color(0xFFF5FEFC), // assumed lightest, use context if clearer
      100: Color(0xFFD8FFD1),
      200: Color(0xFFB1FFA3),
      300: Color(0xFF8AFF75),
      400: Color(0xFF63FF47),
      500: Color(0xFF3CFF1A),
      600: Color(0xFF23EB00),
      700: Color(0xFF1CBD00),
      800: Color(0xFF137D00),
      900: Color(0xFF106B00),
    },
  );

  static const MaterialColor yellow = MaterialColor(0xFFE9FF99, {
    50: Color(0xFFFCFFF2),
    100: Color(0xFFF9FFE5),
    200: Color(0xFFF7FFD9),
    300: Color(0xFFF4FFCC),
    400: Color(0xFFF1FFBF),
    500: Color(0xFFEEFFB3),
    600: Color(0xFFECFFA6),
    700: Color(0xFFDEFF66),
    800: Color(0xFFD3FF33),
    900: Color(0xFFC8FF00),
  });

  static const MaterialColor brown = MaterialColor(0xFFBA9593, {
    50: Color(0xFFF6F2F1),
    100: Color(0xFFEEE4E4),
    200: Color(0xFFE5D7D6),
    300: Color(0xFFDCCAC9),
    400: Color(0xFFD3BCBB),
    500: Color(0xFFCBAFAD),
    600: Color(0xFFC2A1A0),
    700: Color(0xFFA97B79),
    800: Color(0xFF986461),
    900: Color(0xFF7E5351),
  });

  static const MaterialColor purple = MaterialColor(0xFF89608E, {
    50: Color(0xFFF1EBF1),
    100: Color(0xFFE2D7E4),
    200: Color(0xFFD4C3D6),
    300: Color(0xFFC5AFC8),
    400: Color(0xFFB79ABB),
    500: Color(0xFFA886AD),
    600: Color(0xFF9A729F),
    700: Color(0xFF78557D),
    800: Color(0xFF67496B),
    900: Color(0xFF563D59),
  });

  static const MaterialColor deepPurple = MaterialColor(0xFF623B5A, {
    50: Color(0xFFEFE4EC),
    100: Color(0xFFDEC8DA),
    200: Color(0xFFCEADC7),
    300: Color(0xFFBD91B4),
    400: Color(0xFFAD76A2),
    500: Color(0xFF9A5C8D),
    600: Color(0xFF7E4C74),
    700: Color(0xFF563450),
    800: Color(0xFF4A2C44),
    900: Color(0xFF3E2539),
  });
}
