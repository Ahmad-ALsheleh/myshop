import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';

/// A slide of the home carousel ("Fashion Sale / See More").
@immutable
class PromoBanner {
  const PromoBanner({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
  });

  final String id;
  final LocalizedText title;
  final String image;

  /// "See More" opens the items screen of this category.
  final String categoryId;
}
