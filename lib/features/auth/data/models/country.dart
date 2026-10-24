import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';
import '../../../../core/utils/phone_mask.dart';

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
  final PhoneMask mask;

  /// "+380" + digits without spaces: "+380991234567".
  String fullNumber(String localNumber) =>
      '$dialCode${PhoneMask.digitsOf(localNumber)}';
}
