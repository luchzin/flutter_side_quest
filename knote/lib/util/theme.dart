import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00E5FF); // Neon Cyan
  static const Color accentColor = Color(0xFFB000FF); // Neon Purple
  static const Color darkBackground = Color(0xFF0A0A0E); // Deep Dark
  static const Color surfaceColor = Color(0xFF161622); // Slightly lighter

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: const Color(0xFF00B0FF),
      secondary: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFF0F0F5)),
    scaffoldBackgroundColor: const Color(0xFFF7F7FA),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00B0FF),
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      background: darkBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: surfaceColor,
      elevation: 0,
    ),
    scaffoldBackgroundColor: darkBackground,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2A2A35),
      thickness: 1,
    ),
  );
}
