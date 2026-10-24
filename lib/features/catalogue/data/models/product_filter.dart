import 'package:flutter/foundation.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../../../product/data/models/product_sort.dart';

/// Search text, filter screen values and sort order of the items screen.
@immutable
class ProductFilter {
  const ProductFilter({
    this.query = '',
    this.subcategoryId,
    this.minPrice = 0,
    this.maxPrice = maxPriceLimit,
    this.brands = const {},
    this.colors = const {},
    this.sizes = const {},
    this.sort = ProductSort.featured,
  });

  /// Upper end of the price slider ($5000), in cents.
  static const maxPriceLimit = 500000;

  final String query;

  /// `null` means the "All" chip.
  final String? subcategoryId;

  /// Price range in cents, both ends included.
  final int minPrice;
  final int maxPrice;
  final Set<String> brands;
  final Set<ProductColor> colors;
  final Set<ProductSize> sizes;
  final ProductSort sort;

  /// Whether the filter screen changed anything (shows the dot on the filter
  /// icon). Search text and the "All"/subcategory chips are not counted:
  /// they are visible on the items screen itself.
  bool get hasActiveFilters =>
      minPrice != 0 ||
      maxPrice != maxPriceLimit ||
      brands.isNotEmpty ||
      colors.isNotEmpty ||
      sizes.isNotEmpty ||
      sort != ProductSort.featured;

  bool matches(Product product) {
    // An empty set means "any".
    bool allows<T>(Set<T> selected, Iterable<T> values) =>
        selected.isEmpty || values.any(selected.contains);

    return (subcategoryId == null || product.subcategoryId == subcategoryId) &&
        product.price >= minPrice &&
        product.price <= maxPrice &&
        allows(brands, [product.brand]) &&
        allows(colors, product.colors.map((option) => option.color)) &&
        allows(sizes, product.sizes) &&
        _matchesQuery(product);
  }

  bool _matchesQuery(Product product) {
    final text = query.trim();
    if (text.isEmpty) return true;
    return product.name.matches(text) ||
        product.brand.toLowerCase().contains(text.toLowerCase());
  }

  /// Filters then sorts [products].
  List<Product> apply(Iterable<Product> products) =>
      products.where(matches).sortedBy(sort);

  /// [subcategoryId] is a function so that it can be reset to `null` ("All").
  ProductFilter copyWith({
    String? query,
    ValueGetter<String?>? subcategoryId,
    int? minPrice,
    int? maxPrice,
    Set<String>? brands,
    Set<ProductColor>? colors,
    Set<ProductSize>? sizes,
    ProductSort? sort,
  }) {
    return ProductFilter(
      query: query ?? this.query,
      subcategoryId: subcategoryId != null
          ? subcategoryId()
          : this.subcategoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      brands: brands ?? this.brands,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      sort: sort ?? this.sort,
    );
  }

  // Value equality: Riverpod compares states with `==`, and the filter screen
  // compares its draft with the applied filter.
  @override
  bool operator ==(Object other) =>
      other is ProductFilter &&
      other.query == query &&
      other.subcategoryId == subcategoryId &&
      other.minPrice == minPrice &&
      other.maxPrice == maxPrice &&
      setEquals(other.brands, brands) &&
      setEquals(other.colors, colors) &&
      setEquals(other.sizes, sizes) &&
      other.sort == sort;

  @override
  int get hashCode => Object.hash(
    query,
    subcategoryId,
    minPrice,
    maxPrice,
    Object.hashAllUnordered(brands),
    Object.hashAllUnordered(colors),
    Object.hashAllUnordered(sizes),
    sort,
  );
}
