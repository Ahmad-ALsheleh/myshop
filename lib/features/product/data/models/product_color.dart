import 'dart:ui' show Color;

/// Colors a product can come in.
///
/// The swatch is product data (the real color of the item), not a theme
/// color, so it lives here and not in `AppPalette`. The first six are the
/// swatches of the filter screen, sampled from the design.
enum ProductColor {
  black(Color(0xFF34283E)),
  red(Color(0xFFCE3E3E)),
  green(Color(0xFF76B559)),
  blue(Color(0xFF5D72E1)),
  purple(Color(0xFFB768B9)),
  yellow(Color(0xFFE5D227)),
  orange(Color(0xFFF2994A)),
  brown(Color(0xFFA9703F)),
  beige(Color(0xFFE6D8C3)),
  pink(Color(0xFFD99AAE)),
  gray(Color(0xFF8E8E93)),
  white(Color(0xFFFFFFFF));

  const ProductColor(this.swatch);

  final Color swatch;
}
