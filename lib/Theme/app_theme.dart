import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: AppColors.backgroundLight,

      colorScheme: const ColorScheme.light(
        surface: AppColors.white, // Cards, Sheets
        onSurface: AppColors.backgroundDark, // Text on White surfaces

        primary: AppColors.backgroundDark, //
        onPrimary: AppColors.white,

        surfaceContainerLowest: AppColors.backgroundLight,
      ),
      textTheme: AppTextTheme.theme.apply(
        displayColor: AppColors.backgroundDark,
        bodyColor: AppColors.backgroundDark,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: AppColors.white),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.surfaceDark,
        unselectedIconTheme: IconThemeData(color: AppColors.surfaceDark),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.backgroundDark,
        elevation: 0,
      ),
    );
  }

  /// Dark Mode Theme
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: AppColors.backgroundDark,

      colorScheme: const ColorScheme.dark(
        surface: AppColors.cardDark,
        onSurface: AppColors.white,

        primary: AppColors.white,
        onPrimary: AppColors.backgroundDark,

        // Background slots
        surfaceContainer: AppColors.surfaceDark, // (1B1B1B)
        surfaceContainerLow: AppColors.backgroundDark, // (121212)
      ),
      textTheme: AppTextTheme.theme.apply(
        displayColor: AppColors.white,
        bodyColor: AppColors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
    );
  }
}
