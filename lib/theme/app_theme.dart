import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [AppTheme] manages the visual identity of the Nexus Training Tracker.
/// It implements a modern, enterprise-grade design system using Material 3.
class AppTheme {
  // --- Brand Colors ---
  static const Color primaryColor = Color(0xFF1e3c72); // Deep Navy
  static const Color secondaryColor = Color(0xFF2a5298); // Royal Blue
  static const Color accentColor = Color(0xFF00d4ff); // Bright Cyan

  // --- Semantic Colors ---
  static const Color successColor = Color(0xFF10b981); // Emerald
  static const Color warningColor = Color(0xFFf59e0b); // Amber
  static const Color errorColor = Color(0xFFef4444); // Rose

  // --- Background Colors ---
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color darkBg = Color(0xFF0F172A);

  /// Returns the Light Theme configuration.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBg,

      // Modern AppBar with clean look
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),

      // Global Typography System using Outfit for headers and Inter for body
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
            fontWeight: FontWeight.bold, color: primaryColor),
        displayMedium: GoogleFonts.outfit(
            fontWeight: FontWeight.bold, color: primaryColor),
        displaySmall: GoogleFonts.outfit(
            fontWeight: FontWeight.bold, color: primaryColor),
        headlineMedium: GoogleFonts.outfit(
            fontWeight: FontWeight.w600, color: primaryColor),
        titleLarge: GoogleFonts.outfit(
            fontWeight: FontWeight.w600, color: primaryColor),
      ),

      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        surface: Colors.white,
        onSurface: primaryColor,
      ),

      // Custom Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primaryColor.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor);
          }
          return GoogleFonts.inter(fontSize: 12, color: Colors.grey);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor, size: 26);
          }
          return const IconThemeData(color: Colors.grey, size: 24);
        }),
      ),

      // Card Design System: Flat with subtle borders
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Returns the Dark Theme configuration.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBg,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      textTheme:
          GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: GoogleFonts.outfit(
            fontWeight: FontWeight.w600, color: Colors.white),
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        surface: const Color(0xFF1E293B),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
    );
  }
}
