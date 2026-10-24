/// Formats a price in cents the way the design shows it: `$49`, `$89.99`.
///
/// Whole amounts have no decimals. Digits stay Latin in Arabic too, like
/// most Arabic shopping apps.
String formatPrice(int cents) {
  final dollars = cents ~/ 100;
  final rest = cents % 100;
  return rest == 0
      ? '\$$dollars'
      : '\$$dollars.${rest.toString().padLeft(2, '0')}';
}
