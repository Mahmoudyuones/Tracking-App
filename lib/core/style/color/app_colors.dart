import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================
  // Brand / Primary Colors
  // =========================
  static const Color primary = Color(0xFFD21E6A);
  static const Color onPrimary = Color(0xFFF9F9F9);

  // =========================
  // Scaffold Colors
  // =========================
  static const Color lightScaffold = Color(0xFFF9F9F9);

  // =========================
  // UI / Components Colors
  // =========================
  static const Color selectedBottomNaVIcon = primary;
  static const Color unselectedBottomNaVIcon = Color(0xFF7D7D7D);
  static const Color activeBottun = primary;
  static const Color unactiveBottun = Color(0xFFA6A6A6);
  static const Color textHint = Color(0xFFA6A6A6);
  static const Color error = Color(0xFFEF4444);
  static const Color inputBorder = Color(0xFF1D1B20);

  // =========================
  // Text Colors
  // =========================
  static const Color lightTextPrimary = Color(0xFF0C1015);
  static const Color lightTextSecondary = Color(0xFFA6A6A6);
  static const Color lightTextgrey = Color(0xFF535353);
  static const Color lightTextgreen = Color(0xFF0CB359);
  static const Color lightTextred = Color(0xFFEF4444);


  // =========================
  // Common Colors
  // =========================
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteLight = Color(0xFFCFCFCF);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFFA6A6A6);
  static const Color transparent = Color(0x00000000);
  static const Color red = Color(0xFFF40909);
  static const Color green = Color(0xFF10B981);
  static const Color midGray=Color(0xFF878787);
  static const MaterialColor pink=MaterialColor
    (0xFFD21E6A, <int , Color>{
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    0: Color(0xFFD21E6A),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });

}
