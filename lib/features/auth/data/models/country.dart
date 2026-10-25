import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';
import '../../../../core/utils/digit_mask.dart';

/// A country of the phone number picker.
@immutable
class Country {
  const Country({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.mask,
  });

  final String isoCode;
  final LocalizedText name;

  /// With the plus: "+380".
  final String dialCode;

  /// Emoji flag.
  final String flag;
  final DigitMask mask;

  /// "+380" + digits without spaces: "+380991234567".
  String fullNumber(String localNumber) =>
      '$dialCode${DigitMask.digitsOf(localNumber)}';
}

extension CountryLookup on List<Country> {
  /// "+380991234567" → "+380 (99) 123 45 67", with the mask of the country
  /// of the number (longest dial code first). Unknown codes stay as they are.
  String displayNumber(String fullNumber) {
    final byLongestCode = [...this]
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
    for (final country in byLongestCode) {
      if (fullNumber.startsWith(country.dialCode)) {
        final local = fullNumber.substring(country.dialCode.length);
        return '${country.dialCode} ${country.mask.apply(local)}';
      }
    }
    return fullNumber;
  }
}
