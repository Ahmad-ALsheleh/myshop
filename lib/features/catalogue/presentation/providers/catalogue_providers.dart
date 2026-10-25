import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/repositories/product_repository.dart';
import '../../data/models/category.dart';
import '../../data/repositories/category_repository.dart';
import 'product_filter_provider.dart';

final categoriesProvider = Provider<List<Category>>(
  (ref) => ref.watch(categoryRepositoryProvider).getAll(),
);

final categoryProvider = Provider.family<Category?, String>(
  (ref, id) => ref.watch(categoryRepositoryProvider).getById(id),
);

/// Every product of a category, before filtering. The filter screen uses it
/// for the brand list, and to count results while the user edits.
final allCategoryProductsProvider = Provider.family<List<Product>, String>(
  (ref, categoryId) =>
      ref.watch(productRepositoryProvider).getByCategory(categoryId),
);

/// Products shown on the items screen: filtered and sorted.
final categoryProductsProvider = Provider.autoDispose
    .family<List<Product>, String>((ref, categoryId) {
      final filter = ref.watch(productFilterProvider(categoryId));
      return filter.apply(ref.watch(allCategoryProductsProvider(categoryId)));
    });

/// Brands available in a category, A to Z ignoring case (filter "Brand").
final categoryBrandsProvider = Provider.family<List<String>, String>((
  ref,
  categoryId,
) {
  final products = ref.watch(allCategoryProductsProvider(categoryId));
  return {for (final product in products) product.brand}.toList()
    ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
});

/// Colors available in a category, in the order of [ProductColor]
/// (filter screen "Colors").
final categoryColorsProvider = Provider.family<List<ProductColor>, String>((
  ref,
  categoryId,
) {
  final products = ref.watch(allCategoryProductsProvider(categoryId));
  final colors = {
    for (final product in products)
      for (final option in product.colors) option.color,
  };
  return ProductColor.values.where(colors.contains).toList();
});
