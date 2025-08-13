import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFF8685EF),
    secondaryHeaderColor: const Color(0xFFDEDCEE),
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    cardColor: const Color(0xFFFFFFFF),
    fontFamily: 'Pretendard',
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 52, color: Color(0xFF8685EF), fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(fontSize: 48, color: Color(0xFF8685EF), fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontSize: 26, color: Color(0xFF8685EF), fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 18, color: Color(0xFF8685EF), fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
      labelSmall: TextStyle(fontSize: 16, color: Color(0xFF8685EF), fontWeight: FontWeight.w400),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8685EF),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8685EF),
      foregroundColor: Color(0xFFDEDCEE),
    ),
  );
}