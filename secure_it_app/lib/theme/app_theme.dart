import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryNavy = Color(0xFF0A192F);
  static const Color accentTeal = Color(0xFF64FFDA);
  static const Color surfaceColor = Color(0xFF112240);
  static const Color backgroundColor = Color(0xFF020C1B);
  static const Color errorRed = Color(0xFFE53935);
  static const Color warningYellow = Color(0xFFFDD835);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: accentTeal,
        secondary: accentTeal,
        surface: surfaceColor,
        error: errorRed,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: accentTeal),
        titleMedium: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: const TextStyle(fontSize: 18.0, color: Colors.white),
        bodyMedium: const TextStyle(fontSize: 16.0, color: Colors.white70),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryNavy,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentTeal,
          foregroundColor: primaryNavy,
          textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
