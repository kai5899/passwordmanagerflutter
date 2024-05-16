
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';

class AppTheme {
  static const darkTheme = ColorScheme.dark(
    primary: Color(0xFFF8D028),
    onPrimary: Color(0xFF333333),
    primaryContainer: Color(0xFFD0C000),
    onPrimaryContainer: Color(0xFF333333),
    secondary: Color(0xFF3B9DFF),
    onSecondary: Color(0xFFF3F3F3),
    secondaryContainer: Color(0xFFF0A000),
    onSecondaryContainer: Color(0xFF333333),
    error: Colors.redAccent,
    onError: Colors.red,
    errorContainer: Colors.redAccent,
    onErrorContainer: Color(0xFFF9DEDC),
    outline: Color(0xFF938F99),
    background: Color(0xFF333333),
    onBackground: Color(0xFFF3F3F3),
    surface: Color(0xFF333333),
    onSurface: Color(0xFFF3F3F3),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
  );

  static ColorScheme lightTheme = ColorScheme.light(
    primary:  Get.put(RootController()).primaryColor.value,
    onPrimary: const Color(0xFF333333),
    primaryContainer:  Colours.lokiDarkGreen,
    onPrimaryContainer: const Color(0xFF333333),
    secondary: const Color(0xFF3B9DFF),
    onSecondary: const Color(0xFFF3F3F3),
    secondaryContainer: Colors.amber.shade700,
    onSecondaryContainer: const Color(0xFF333333),
    error: Colors.redAccent,
    onError: Colors.red,
    errorContainer: Colors.redAccent,
    onErrorContainer: const Color(0xFFF9DEDC),
    outline: const Color(0xFF6F6D73),
    background: Colors.white,
    onBackground: const Color(0xFF333333),
    surface: Colours.lokiDarkGreen,
    onSurface: Colors.black,
    surfaceVariant: const Color(0xFF57545B),
    onSurfaceVariant: const Color(0xFF757575),
  );

  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: 'ocr-a',
    colorScheme: lightTheme,
  );
  static final dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'ocr-a',
    colorScheme: darkTheme,
  );
}