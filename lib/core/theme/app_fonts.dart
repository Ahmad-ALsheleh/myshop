import 'package:flutter/widgets.dart';

/// Font families registered in `pubspec.yaml`.
abstract final class AppFonts {
  /// Latin text. Open-source substitute for the SF Pro look of the design.
  static const latin = 'Inter';

  /// Arabic text (Inter has no Arabic glyphs).
  static const arabic = 'Tajawal';

  /// The "MyShop" wordmark only.
  static const logo = 'Montserrat';

  static String forLocale(Locale locale) =>
      locale.languageCode == 'ar' ? arabic : latin;

  /// Inter is wider than SF Pro, the font of the design: a slightly negative
  /// tracking brings Latin text widths close to the design.
  static const latinLetterSpacing = -0.5;

  /// Arabic keeps 0: spacing would pull the joined letters apart.
  static double letterSpacingFor(String family) =>
      family == latin ? latinLetterSpacing : 0;
}
