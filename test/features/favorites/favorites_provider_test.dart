import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:myshop/features/product/data/mock/mock_products.dart';
import 'package:myshop/features/product/data/models/product_sort.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer.test());

  test('starts with the 5 favorites of the design, lowest price first', () {
    expect(container.read(favoriteProductsProvider), [
      saodimallsuTurtleneck,
      larkRoSkirt,
      larkRoJeggings,
      larkRoSwingDress,
      astylishCardigan,
    ]);
  });

  test('toggle removes and adds back', () {
    final notifier = container.read(favoritesProvider.notifier);

    notifier.toggle(astylishCardigan.id);
    expect(container.read(isFavoriteProvider(astylishCardigan.id)), isFalse);
    expect(container.read(favoriteProductsProvider), hasLength(4));

    notifier.toggle(astylishCardigan.id);
    expect(container.read(isFavoriteProvider(astylishCardigan.id)), isTrue);
  });

  test('the sort can be changed', () {
    container
        .read(favoritesSortProvider.notifier)
        .select(ProductSort.priceHighToLow);

    expect(container.read(favoriteProductsProvider).first, astylishCardigan);
  });
}
