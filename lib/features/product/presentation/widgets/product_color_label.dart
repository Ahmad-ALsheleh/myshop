import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../data/models/product_color.dart';

extension ProductColorLabel on ProductColor {
  /// Translated name, read by screen readers on color selectors.
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      ProductColor.black => l10n.colorBlack,
      ProductColor.red => l10n.colorRed,
      ProductColor.green => l10n.colorGreen,
      ProductColor.blue => l10n.colorBlue,
      ProductColor.purple => l10n.colorPurple,
      ProductColor.yellow => l10n.colorYellow,
      ProductColor.orange => l10n.colorOrange,
      ProductColor.brown => l10n.colorBrown,
      ProductColor.beige => l10n.colorBeige,
      ProductColor.pink => l10n.colorPink,
      ProductColor.gray => l10n.colorGray,
      ProductColor.white => l10n.colorWhite,
    };
  }
}
