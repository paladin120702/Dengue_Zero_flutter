import 'package:flutter/material.dart';

abstract class AllThemes {
  static final theme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Color(0xFFC62828),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 60),
        backgroundColor: const Color(0xFFC62828),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Color(0xFFC62828),
        fontWeight: FontWeight.bold,
        fontSize: 50,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.red.shade50,
      labelStyle: const TextStyle(
        color: Color(0xFFC62828),
        fontWeight: FontWeight.bold,
      ),
      floatingLabelStyle: const TextStyle(
        color: Color(0xFFB71C1C),
        fontWeight: FontWeight.bold,
      ),
      prefixIconColor: const Color(0xFFD32F2F),
      suffixIconColor: const Color(0xFFD32F2F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE57373),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFB71C1C),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD32F2F),
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFB71C1C),
          width: 2,
        ),
      ),
      hintStyle: const TextStyle(
        color: Color(0xFFE57373),
      ),
      helperStyle: const TextStyle(
        color: Color(0xFFEF5350),
      ),
    ),
  );
}
