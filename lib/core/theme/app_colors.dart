import 'package:flutter/material.dart';

/// Raw color tokens, sampled from the Figma PNG exports.
///
/// Widgets must NOT use these directly. Use [AppPalette] through
/// `context.palette` so that light/dark themes switch automatically.
abstract final class AppColors {
  // Brand
  static const brandDark = Color(0xFF34283E);
  static const brandLight = Color(0xFF845FA1);
  static const accent = Color(0xFFE7B844);
  static const brandLink = Color(0xFF5A426D);
  static const darkBrandLink = Color(0xFFB79AD0);

  // Light surfaces & text
  static const lightBackground = Color(0xFFF3F3F3);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF34283E);
  static const lightTextBody = Color(0xFF605A65);
  static const textSecondary = Color(0xFF9B9B9B);
  static const lightBorder = Color(0xFFE0E0E0);
  static const lightHint = Color(0xFFE0E0E0);

  // Dark surfaces & text (derived: the Figma file has no dark mode)
  static const darkBackground = Color(0xFF18131D);
  static const darkSurface = Color(0xFF241D2B);
  static const darkTextPrimary = Color(0xFFF3F3F3);
  static const darkTextBody = Color(0xFFC9C2CF);
  static const darkBorder = Color(0xFF3A3142);
  static const darkHint = Color(0xFF5E5466);

  // Semantic
  static const sale = Color(0xFFCE3E3E);
  static const saleBadgeStart = Color(0xFFD84840);
  static const saleBadgeEnd = Color(0xFFF18D5E);
  static const rating = Color(0xFFF2994A);
  static const success = Color(0xFF46AB62);
  static const white = Color(0xFFFFFFFF);
  static const imageOverlay = Color(0x59000000); // 35% black over photos
}
