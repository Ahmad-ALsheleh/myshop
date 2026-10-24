import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';

@immutable
class Review {
  const Review({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.date,
    required this.text,
    this.helpfulCount = 0,
  });

  final String id;
  final String authorName;

  /// From 1 to 5.
  final int rating;
  final DateTime date;
  final LocalizedText text;

  /// "835 people found this helpful".
  final int helpfulCount;
}
