import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_products.dart';
import '../models/product.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(),
);

/// Read access to the product catalog.
///
/// Backed by in-memory mock data, so every call is synchronous. Swapping in a
/// real API only touches this class and the providers that call it.
class ProductRepository {
  List<Product> getAll() => mockProducts;

  Product? getById(String id) =>
      mockProducts.where((product) => product.id == id).firstOrNull;

  /// Keeps the order of [ids] and skips unknown ones.
  List<Product> getByIds(Iterable<String> ids) => [
    for (final id in ids) ?getById(id),
  ];

  List<Product> getFeatured() =>
      mockProducts.where((product) => product.isFeatured).toList();

  List<Product> getByCategory(String categoryId) => mockProducts
      .where((product) => product.categoryId == categoryId)
      .toList();

  /// Same subcategory first, then the rest of the category.
  List<Product> getRelated(Product product, {int limit = 6}) {
    final others = getByCategory(
      product.categoryId,
    ).where((other) => other.id != product.id);
    return [
      ...others.where((other) => other.subcategoryId == product.subcategoryId),
      ...others.where((other) => other.subcategoryId != product.subcategoryId),
    ].take(limit).toList();
  }
}
