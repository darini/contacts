import 'package:contacts/shared/styles.dart';
import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = basePrimaryColor;
const accentColor = baseAccentColor;

ThemeData androidTheme() {
  return ThemeData(
    brightness: brightness,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontFamily: "Poppins",
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
      ),
      labelLarge: TextStyle(
        fontFamily: "Poppins",
      ),
      displaySmall: TextStyle(
        fontFamily: "Poppins",
      ),
      displayMedium: TextStyle(
        fontFamily: "Poppins",
      ),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
      ),
      headlineSmall: TextStyle(
        fontFamily: "Poppins",
      ),
      labelSmall: TextStyle(
        fontFamily: "Poppins",
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
      ),
      titleMedium: TextStyle(
        fontFamily: "Poppins",
      ),
      titleLarge: TextStyle(
        fontFamily: "Poppins",
      ),
    ),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme(
      brightness: brightness,
      primary: primaryColor,
      onPrimary: accentColor,
      secondary: accentColor,
      onSecondary: primaryColor,
      error: accentColor,
      onError: primaryColor,
      background: primaryColor,
      onBackground: accentColor,
      surface: accentColor,
      onSurface: primaryColor,
    ),
  );
}
