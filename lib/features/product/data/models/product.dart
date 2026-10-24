import 'package:flutter/foundation.dart';

import '../../../../core/l10n/localized_text.dart';
import 'product_color.dart';
import 'product_size.dart';

/// One selectable color of a product, with the photo of that color.
@immutable
class ProductColorOption {
  const ProductColorOption({required this.color, required this.image});

  final ProductColor color;
  final String image;
}

@immutable
class Product {
  const Product({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.brand,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.rating,
    this.oldPrice,
    this.colors = const [],
    this.sizes = const [],
    this.inStock = true,
    this.isFeatured = false,
  });

  final String id;
  final String categoryId;
  final String subcategoryId;
  final String brand;
  final LocalizedText name;
  final LocalizedText description;

  /// Current price in cents (`8999` = $89.99). Integers keep totals exact.
  final int price;

  /// Price before the discount, in cents. `null` when not on sale.
  final int? oldPrice;

  /// Gallery images (asset paths). The first one is the thumbnail.
  final List<String> images;
  final List<ProductColorOption> colors;
  final List<ProductSize> sizes;

  /// Average rating from 0 to 5.
  final double rating;
  final bool inStock;
  final bool isFeatured;

  String get thumbnail => images.first;

  bool get isOnSale => oldPrice != null;

  /// Whole-percent discount, rounded down: $49 instead of $99 is 50%.
  int get discountPercent =>
      isOnSale ? (oldPrice! - price) * 100 ~/ oldPrice! : 0;

  /// Photo of [color], or the thumbnail when that color has no photo.
  String imageFor(ProductColor? color) {
    for (final option in colors) {
      if (option.color == color) return option.image;
    }
    return thumbnail;
  }
}
