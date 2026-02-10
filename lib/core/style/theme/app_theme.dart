import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: .light,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    fontFamily: GoogleFonts.inter().fontFamily,
    //------------ App Bar Theme -----------------//
    appBarTheme: const AppBarThemeData(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.black, size: 30),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    //------------ Bottom Navigation Bar Theme -----------------//
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteLight,
      selectedItemColor: AppColors.selectedBottomNaVIcon,
      unselectedItemColor: AppColors.unselectedBottomNaVIcon,
      elevation: 1,
      type: .fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        color: AppColors.selectedBottomNaVIcon,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        color: AppColors.unselectedBottomNaVIcon,
      ),
    ),
    //------------ Text Form Field Theme -----------------//
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
      hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.inputBorder, width: 2),
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
        color: AppColors.lightTextPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: .w400,
        color: AppColors.lightTextPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: .w400,
        color: AppColors.lightTextPrimary,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: .w400,
        color: AppColors.lightTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: .w400,
        color: AppColors.lightTextPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: .w400,
        color: AppColors.lightTextPrimary,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: .w500,
        color: AppColors.lightTextPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.lightTextPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w500,
        color: AppColors.lightTextPrimary,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: .w500,
        color: AppColors.lightTextPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: .w500,
        color: AppColors.lightTextSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: .w500,
        color: AppColors.lightTextSecondary,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.lightTextSecondary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.lightTextSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: .w400,
        color: AppColors.lightTextSecondary,
      ),
    ),

    //------------ Button Theme -----------------//
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.activeBottun,
        disabledBackgroundColor: AppColors.unactiveBottun,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: .w500,
          color: AppColors.onPrimary,
        ),
      ),
    ),
    //------------ Outlined Button Theme -----------------//
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.white,
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
    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),
    //------------ Icon Button Theme -----------------//
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(padding: EdgeInsets.zero),
    ),
    //------------ Checkbox Theme -----------------//
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.white),
      checkColor: WidgetStateProperty.all(AppColors.primary),
    ),
    //------------ Radio Theme -----------------//
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),
    //------------ Switch Theme -----------------//
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.white),
      // ignore: deprecated_member_use
      trackColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
    ),
    //------------ Alert Dialog Theme -----------------//
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: .w600,
        color: AppColors.lightTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.lightTextSecondary,
      ),
    ),
    //------------ Card Theme -----------------//
    cardTheme: CardThemeData(
      clipBehavior: .antiAlias,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
    ),
    //------------ PIN CODE INPUT Theme -----------------//
  );
}
