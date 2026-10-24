import 'package:flutter/widgets.dart';

import 'app_fonts.dart';

/// Type scale from the Figma screens.
///
/// Styles intentionally have no color and no font family: they inherit both
/// from the active theme, so the same style works in light/dark and
/// in Arabic/English. Add color at the call site through `context.palette`.
abstract final class AppTextStyles {
  /// "What Is Your Phone Number?", "Verification Code".
  static const display = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  /// Section titles: "Featured", "Catalogue", "Shipping Address".
  static const headline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// App bar titles, "Total price", "Success".
  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Button labels.
  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Descriptions, input text.
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Product names, review text.
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// "Colors", "Sizes", "Price", "Sort by" labels.
  static const label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// Prices on product cards.
  static const price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Prices on product page / totals.
  static const priceLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Bottom navigation labels, badges, review counts.
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// "MyShop" wordmark (stays in Latin script in both languages).
  static const logo = TextStyle(
    fontFamily: AppFonts.logo,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    height: 1.2,
  );
}
