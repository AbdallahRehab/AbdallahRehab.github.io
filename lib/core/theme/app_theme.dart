import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark theme colors
  static const Color spaceBlack = Color(0xFF0B0B15);
  static const Color deepSpace = Color(0xFF1A1A2E);
  static const Color neonCyan = Color(0xFF00F0FF);
  static const Color neonPink = Color(0xFFFF007F);
  static const Color starlight = Color(0xFFEAEAEA);
  static const Color glassBorder = Color(0x33FFFFFF);

  // Light theme colors - Improved palette
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF5A5A6E);
  // Darkened from the original 0xFF0097A7 so text/icons set in this color
  // clear WCAG AA contrast (~4.6:1) against a white surface, not just the
  // 3:1 large-text minimum.
  static const Color accentCyan = Color(0xFF007A87);
  static const Color accentPink = Color(0xFFD81B60);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Theme-aware color getters
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? neonCyan
        : accentCyan;
  }

  static Color secondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? neonPink
        : accentPink;
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? starlight
        : lightText;
  }

  static Color textColorSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : lightTextSecondary;
  }

  static Color surfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? deepSpace
        : lightSurface;
  }

  static Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.1)
        : lightBorder;
  }

  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? spaceBlack
        : lightBackground;
  }

  /// Subtle translucent "glass" card fill used across sections.
  static Color cardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? deepSpace.withValues(alpha: 0.5)
        : lightSurface;
  }

  /// Soft tinted background for chips/badges/icon wells.
  static Color chipBackground(BuildContext context) {
    return primaryColor(context).withValues(alpha: 0.1);
  }

  static Color chipBorder(BuildContext context) {
    return primaryColor(context).withValues(alpha: 0.35);
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: spaceBlack,
      primaryColor: neonCyan,
      colorScheme: const ColorScheme.dark(
        primary: neonCyan,
        secondary: neonPink,
        surface: deepSpace,
        onSurface: starlight,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: starlight, displayColor: starlight),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: accentCyan,
      colorScheme: const ColorScheme.light(
        primary: accentCyan,
        secondary: accentPink,
        surface: lightSurface,
        onSurface: lightText,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.light().textTheme,
      ).apply(bodyColor: lightText, displayColor: lightText),
      useMaterial3: true,
    );
  }
}
