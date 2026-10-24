import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/catalogue/data/mock/mock_categories.dart';
import 'package:myshop/features/favorites/data/mock/mock_favorites.dart';
import 'package:myshop/features/product/data/mock/mock_products.dart';
import 'package:myshop/features/product/data/mock/mock_reviews.dart';

/// Catches broken references in the hand-written mock data.
void main() {
  final productIds = {for (final p in mockProducts) p.id};

  test('product ids are unique', () {
    expect(productIds, hasLength(mockProducts.length));
  });

  test('every product points to an existing category and subcategory', () {
    for (final product in mockProducts) {
      final category = mockCategories
          .where((c) => c.id == product.categoryId)
          .single;
      expect(
        category.subcategories.map((s) => s.id),
        contains(product.subcategoryId),
        reason: product.id,
      );
    }
  });

  test('every category has products', () {
    for (final category in mockCategories) {
      expect(
        mockProducts.where((p) => p.categoryId == category.id),
        isNotEmpty,
        reason: category.id,
      );
    }
  });

  test('every product has an image and a valid rating and price', () {
    for (final product in mockProducts) {
      expect(product.images, isNotEmpty, reason: product.id);
      expect(product.rating, inInclusiveRange(0, 5), reason: product.id);
      expect(product.price, isPositive, reason: product.id);
      if (product.oldPrice case final oldPrice?) {
        expect(oldPrice, greaterThan(product.price), reason: product.id);
      }
    }
  });

  test('reviews and favorites refer to existing products', () {
    expect(productIds, containsAll(mockProductReviews.keys));
    expect(productIds, containsAll(mockFavoriteIds));
  });
}
