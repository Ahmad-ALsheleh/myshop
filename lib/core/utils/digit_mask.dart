import 'package:flutter/services.dart';

/// A layout for digits where `#` is a digit: phone numbers
/// `(##) ### ## ##`, card numbers `#### #### #### ####`, expiry `##/##`.
class DigitMask {
  const DigitMask(this.pattern);

  final String pattern;

  static const _digit = '#';

  /// How many digits a complete value has.
  int get length => _digit.allMatches(pattern).length;

  static String digitsOf(String text) => text.replaceAll(RegExp(r'\D'), '');

  /// Lays out the digits of [text] on the mask, stopping after the last one.
  String apply(String text) {
    final digits = digitsOf(text);
    final buffer = StringBuffer();
    var next = 0;
    for (final char in pattern.split('')) {
      if (next == digits.length) break;
      if (char == _digit) {
        buffer.write(digits[next++]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  bool isComplete(String? text) => digitsOf(text ?? '').length == length;

  /// Formats the input while typing; extra digits are ignored.
  TextInputFormatter get formatter => _DigitMaskFormatter(this);
}

class _DigitMaskFormatter extends TextInputFormatter {
  const _DigitMaskFormatter(this.mask);

  final DigitMask mask;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = mask.apply(newValue.text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
