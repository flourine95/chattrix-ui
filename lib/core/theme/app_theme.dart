import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightPrimaryColor = Colors.black;
  static const _lightOnPrimaryColor = Colors.white;
  static const _lightBackgroundColor = Colors.white;
  static const _lightSurfaceColor = Colors.white;
  static const _lightOnSurfaceColor = Colors.black;
  static const _lightBorderColor = Colors.grey;

  static const _darkPrimaryColor = Colors.white;
  static const _darkOnPrimaryColor = Colors.black;
  static const _darkBackgroundColor = Colors.black;
  static const _darkSurfaceColor = Colors.black;
  static const _darkOnSurfaceColor = Colors.white;
  static const _darkBorderColor = Colors.grey;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: _lightOnSurfaceColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      surface: _lightSurfaceColor,
      onSurface: _lightOnSurfaceColor,
    ),
    inputDecorationTheme: _inputDecorationTheme(borderColor: _lightBorderColor),
    elevatedButtonTheme: _elevatedButtonTheme(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: _lightOnPrimaryColor,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      foregroundColor: _lightOnSurfaceColor,
      borderColor: _lightBorderColor,
    ),
    textButtonTheme: _textButtonTheme(primaryColor: _lightPrimaryColor),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: _darkOnSurfaceColor,
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      onPrimary: _darkOnPrimaryColor,
      surface: _darkSurfaceColor,
      onSurface: _darkOnSurfaceColor,
    ),
    inputDecorationTheme: _inputDecorationTheme(borderColor: _darkBorderColor),
    elevatedButtonTheme: _elevatedButtonTheme(
      backgroundColor: _darkPrimaryColor,
      foregroundColor: _darkOnPrimaryColor,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      foregroundColor: _darkOnSurfaceColor,
      borderColor: _darkBorderColor,
    ),
    textButtonTheme: _textButtonTheme(primaryColor: _darkPrimaryColor),
  );

  static InputDecorationTheme _inputDecorationTheme({
    required Color borderColor,
  }) {
    return InputDecorationTheme(
      labelStyle: TextStyle(color: borderColor),
      floatingLabelStyle: TextStyle(color: borderColor.withValues(alpha: 0.8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderColor.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme({
    required Color foregroundColor,
    required Color borderColor,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: BorderSide(color: borderColor.withValues(alpha: 0.5)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme({required Color primaryColor}) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
