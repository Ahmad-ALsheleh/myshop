import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/catalogue/data/mock/mock_categories.dart';
import 'package:myshop/features/catalogue/data/models/product_filter.dart';
import 'package:myshop/features/catalogue/presentation/providers/catalogue_providers.dart';
import 'package:myshop/features/catalogue/presentation/providers/product_filter_provider.dart';
import 'package:myshop/features/product/data/mock/mock_products.dart';
import 'package:myshop/features/product/data/models/product.dart';
import 'package:myshop/features/product/data/models/product_color.dart';
import 'package:myshop/features/product/data/models/product_size.dart';
import 'package:myshop/features/product/data/models/product_sort.dart';

void main() {
  final women = mockProducts
      .where((p) => p.categoryId == CategoryIds.womensFashion)
      .toList();

  List<String> ids(List<Product> products) => [for (final p in products) p.id];

  test('the default filter keeps every product in featured order', () {
    expect(const ProductFilter().apply(women), women);
    expect(const ProductFilter().hasActiveFilters, isFalse);
  });

  test('filters by subcategory', () {
    const filter = ProductFilter(subcategoryId: SubcategoryIds.womenDresses);

    expect(ids(filter.apply(women)), [boriflorsDress.id, larkRoMaxiDress.id]);
  });

  test('filters by price range, both ends included', () {
    const filter = ProductFilter(minPrice: 4900, maxPrice: 8254);

    expect(ids(filter.apply(women)), [
      saodimallsuSweater.id,
      jouicaCardigan.id,
      biuclyHoodie.id,
      larkRoSkirt.id,
      larkRoJeans.id,
      larkRoMaxiDress.id,
    ]);
  });

  test('brands, colors and sizes must all match', () {
    const filter = ProductFilter(
      brands: {'Lark & Ro'},
      colors: {ProductColor.brown},
      sizes: {ProductSize.xs},
    );

    // The maxi dress is brown too, but has no XS.
    expect(ids(filter.apply(women)), [larkRoSkirt.id]);
    expect(filter.hasActiveFilters, isTrue);
  });

  test('searches names in both languages and brands', () {
    expect(ids(const ProductFilter(query: ' cardigan ').apply(women)), [
      astylishCardigan.id,
      ecowishCardigan.id,
      jouicaCardigan.id,
    ]);
    expect(ids(const ProductFilter(query: 'فستان').apply(women)), [
      boriflorsDress.id,
      larkRoMaxiDress.id,
    ]);
    expect(const ProductFilter(query: 'ecowish').apply(women), [ecowishCardigan]);
  });

  test('sorts by price', () {
    final sorted = const ProductFilter(
      sort: ProductSort.priceLowToHigh,
    ).apply(women).map((p) => p.price).toList();

    expect(sorted, [...sorted]..sort());
  });

  test('equal values make equal filters, whatever the set order', () {
    expect(
      const ProductFilter(brands: {'A', 'B'}, sizes: {ProductSize.s}),
      const ProductFilter(brands: {'B', 'A'}, sizes: {ProductSize.s}),
    );
  });

  test('the sale badge shows -50% for \$49 instead of \$99', () {
    expect(saodimallsuSweater.discountPercent, 50);
    expect(astylishCardigan.discountPercent, 0);
  });

  group('providers', () {
    late ProviderContainer container;
    const id = CategoryIds.womensFashion;

    setUp(() => container = ProviderContainer.test());

    test('the items screen list follows the filter of its category', () {
      final subscription = container.listen(
        categoryProductsProvider(id),
        (_, _) {},
      );
      expect(subscription.read(), hasLength(12));

      container
          .read(productFilterProvider(id).notifier)
          .selectSubcategory(SubcategoryIds.womenJeans);
      expect(subscription.read(), [larkRoJeans]);

      // Other categories keep their own filter.
      expect(
        container.read(categoryProductsProvider(CategoryIds.phones)),
        hasLength(2),
      );
    });

    test('applying the filter screen draft keeps the search text', () {
      final keepAlive = container.listen(productFilterProvider(id), (_, _) {});
      container.read(productFilterProvider(id).notifier)
        ..search('lark')
        ..apply(const ProductFilter(sort: ProductSort.priceHighToLow));

      expect(keepAlive.read().query, 'lark');
      expect(keepAlive.read().sort, ProductSort.priceHighToLow);
    });

    test('brands of a category are unique and sorted', () {
      expect(container.read(categoryBrandsProvider(id)), [
        'Angashion',
        'Astylish',
        'Biucly',
        'BORIFLORS',
        'ECOWISH',
        'Jouica',
        'Lark & Ro',
        'Saodimallsu',
        'Simplee',
        'VOIANLIMO',
      ]);
    });
  });
}
