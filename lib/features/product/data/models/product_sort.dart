import 'product.dart';

/// "Sort by" options of the items, filter and favorite screens.
enum ProductSort { featured, priceLowToHigh, priceHighToLow, topRated }

extension ProductSorting on Iterable<Product> {
  /// Returns a new sorted list. [ProductSort.featured] keeps the curated
  /// order of the data.
  List<Product> sortedBy(ProductSort sort) {
    final products = toList();
    switch (sort) {
      case ProductSort.featured:
        break;
      case ProductSort.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.topRated:
        products.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return products;
  }
}
