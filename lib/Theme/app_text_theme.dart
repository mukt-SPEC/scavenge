import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme get theme {
    return TextTheme(
      labelSmall: _geist(10.0, FontWeight.w500),

      labelMedium: _geist(12.0, FontWeight.w500),

      labelLarge: _geist(14.0, FontWeight.w500),

      bodySmall: _geist(16.0, FontWeight.w400),

      bodyMedium: _geist(18.0, FontWeight.w400),

      bodyLarge: _geist(20.0, FontWeight.w400),

      titleSmall: _geist(22.0, FontWeight.w500),

      titleMedium: _geist(24.0, FontWeight.w500),

      titleLarge: _geist(26.0, FontWeight.w600),

      headlineSmall: _geist(28.0, FontWeight.w400),

      headlineMedium: _geist(30.0, FontWeight.w400),

      headlineLarge: _geist(32.0, FontWeight.w600),

      displaySmall: _geist(34.0, FontWeight.w400),

      displayMedium: _geist(36.0, FontWeight.w400),

      displayLarge: _geist(38.0, FontWeight.w600),
    );
  }

  static TextStyle _geist(double size, FontWeight weight) {
    return GoogleFonts.geist(fontSize: size, fontWeight: weight);
  }
}
