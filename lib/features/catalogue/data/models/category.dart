import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';

/// A chip on the items screen ("Dresses", "Tops", ...).
@immutable
class Subcategory {
  const Subcategory({required this.id, required this.name});

  final String id;
  final LocalizedText name;
}

@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.image,
    this.subcategories = const [],
  });

  final String id;
  final LocalizedText name;
  final String image;
  final List<Subcategory> subcategories;
}
