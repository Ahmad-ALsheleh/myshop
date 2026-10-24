import 'package:flutter/painting.dart';

import 'app_palette.dart';

/// Soft drop shadows of the design (search field, cards, heart button,
/// bottom panels). The color comes from the palette so dark mode can use a
/// stronger one.
abstract final class AppShadows {
  /// Cards, search field, heart button.
  static List<BoxShadow> soft(AppPalette palette) => [
    BoxShadow(
      color: palette.shadow,
      blurRadius: 24,
      offset: const Offset(0, 6),
    ),
  ];

  /// Bottom navigation and bottom panels (shadow goes up).
  static List<BoxShadow> raised(AppPalette palette) => [
    BoxShadow(
      color: palette.shadow,
      blurRadius: 20,
      offset: const Offset(0, -4),
    ),
  ];
}
