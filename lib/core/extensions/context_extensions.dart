import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../l10n/localized_text.dart';
import '../theme/app_palette.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  /// Picks the right language of a data text for the current locale.
  String localize(LocalizedText text) =>
      text.resolve(Localizations.localeOf(this));
}
