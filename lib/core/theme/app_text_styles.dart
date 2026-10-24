import 'package:flutter/widgets.dart';

import 'app_fonts.dart';

/// Type scale measured from the Figma screens (cap heights of the @2x/@3x
/// exports).
///
/// Styles intentionally have no color and no font family: they inherit both
/// from the active theme, so the same style works in light/dark and
/// in Arabic/English. Add color at the call site through `context.palette`.
abstract final class AppTextStyles {
  /// "What Is Your Phone Number?", "Verification Code".
  static const display = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  /// Section titles ("Featured", "Catalogue"), header titles, "Total price".
  static const headline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Labels of the 48pt buttons.
  static const button = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Labels of the 64pt buttons of the sign in screens.
  static const buttonLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Sign in subtitles and the phone number input.
  static const bodyLarge = TextStyle(
    fontSize: 17.5, // same cap height as the 18pt SF Pro of the design
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  /// Product names, descriptions, input text, size chips.
  static const body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.27, // 19pt lines
  );

  /// Search placeholder, crossed-out old price.
  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  /// "Colors", "Sizes", "Price", "Sort by" labels.
  static const label = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// Prices on product cards and cart lines.
  static const price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Prices on the product page and totals.
  static const priceLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Bottom navigation labels, cart pill, badges.
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Digits of the verification code.
  static const codeDigit = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  /// Small links and notes: "Change Phone Number", review dates.
  static const footnote = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  /// "MyShop" wordmark (stays in Latin script in both languages).
  static const logo = TextStyle(
    fontFamily: AppFonts.logo,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
