import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: .light,
    scaffoldBackgroundColor: AppColors.whiteBase,
    fontFamily: GoogleFonts.inter().fontFamily,
    //------------ App Bar Theme -----------------//
    appBarTheme: const AppBarThemeData(
      backgroundColor: AppColors.whiteBase,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.mainBase, size: 30),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: AppColors.blackBase,
        fontWeight: FontWeight.w500,
      ),
    ),
    //------------ Bottom Navigation Bar Theme -----------------//
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white60,
      selectedItemColor: AppColors.mainBase,
      unselectedItemColor: AppColors.white80,
      elevation: 1,
      type: .fixed,
      selectedLabelStyle: TextStyle(fontSize: 12, color: AppColors.mainBase),
      unselectedLabelStyle: TextStyle(fontSize: 12, color: AppColors.white80),
    ),
    //------------ Text Form Field Theme -----------------//
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.gray),
      hintStyle: const TextStyle(color: AppColors.white70, letterSpacing: 0.5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.gray, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),
    //------------ Text Theme -----------------//
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: .w500,
        color: AppColors.blackBase,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gray,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: .w400,
        color: AppColors.blackBase,
      ),
    ),

    //------------ Button Theme -----------------//
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainBase,
        disabledBackgroundColor: AppColors.black30,
        foregroundColor: AppColors.whiteBase,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: .w500,
          color: AppColors.whiteBase,
        ),
      ),
    ),
    //------------ Outlined Button Theme -----------------//
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.whiteBase,
        foregroundColor: AppColors.gray,
        elevation: 0,
        side: const BorderSide(color: AppColors.gray, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.gray,
        ),
      ),
    ),
    //------------ Icon Theme -----------------//
    iconTheme: const IconThemeData(color: AppColors.whiteBase, size: 24),
    //------------ Icon Button Theme -----------------//
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(padding: EdgeInsets.zero),
    ),
    //------------ Checkbox Theme -----------------//
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.mainBase),
      checkColor: WidgetStateProperty.all(AppColors.whiteBase),
    ),
    //------------ Radio Theme -----------------//
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.mainBase),
    ),
    //------------ Switch Theme -----------------//
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.whiteBase),
      trackColor: WidgetStateProperty.all(AppColors.success),
    ),
    //------------ Alert Dialog Theme -----------------//
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.whiteBase,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: .w600,
        color: AppColors.blackBase,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.blackBase,
      ),
    ),
    //------------ Card Theme -----------------//
    cardTheme: CardThemeData(
      clipBehavior: .antiAlias,
      color: AppColors.whiteBase,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
    ),
    //------------ PIN CODE INPUT Theme -----------------//
  );
}
