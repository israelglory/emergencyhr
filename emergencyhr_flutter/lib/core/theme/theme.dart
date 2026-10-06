import 'package:emergencyhr_flutter/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  // static final _darkTheme = ThemeData();

  static _themeData(ColorScheme colorScheme) => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    colorScheme: colorScheme,
    fontFamily: 'Inter',
    textTheme: GoogleFonts.interTextTheme(
      _textTheme(colorScheme),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    ),
  );

  static final ColorScheme _lightColorScheme = const ColorScheme.light()
      .copyWith(
        primary: AppColors.deepGreen,
        secondary: Colors.black,
        secondaryContainer: Colors.black,
        onSurface: Colors.black,
      );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontFamily: "Inter",
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontFamily: 'Inter',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: colorScheme.onSurface,
      fontFamily: "Inter",
    ),
    bodyMedium: TextStyle(
      color: colorScheme.onSurface,
      fontFamily: "Inter",
    ),
  );
}
