import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // App Basic Colors
  static const Color primaryColor = Color(0xFF6C5DD3);
  static const Color secondaryColor = Color(0xFFFFE24B);
  static const Color accentColor = Color(0xFFb0c7ff);
  static const Color primaryLight = Color(0xFF8B7DE0);
  static const Color primaryDark = Color(0xFF4E3DB3);

  // Accent
  static const Color accent = Color(0xFF8BAF4F);
  static const Color accentLight = Color(0xFFA8C870);

  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFFB0B7C3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static const Color background = Color(0xFFEEECFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F3FF);

  // Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = Colors.white.withValues(alpha: 0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF8074CB);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  // Gradient Colors
  static const Gradient linerGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xffff9a9e), Color(0xfffad0c4), Color(0xfffad0c4)],
  );

  // Utility
  static const Color divider = Color(0xFFE5E7EB);
  static const Color shadow = Color(0x1A6C5DD3);
  static const Color overlay = Color(0x80000000);

  // Card shadow color
  static const Color cardShadow = Color(0x146C5DD3);
}
