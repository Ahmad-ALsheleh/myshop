import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/models/product_sort.dart';
import '../../../product/data/repositories/product_repository.dart';
import '../../data/repositories/favorites_repository.dart';

/// Ids of the favorite products, in the order they were added.
final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() =>
      ref.watch(favoritesRepositoryProvider).loadFavoriteIds();

  void toggle(String productId) => state = state.contains(productId)
      ? state.where((id) => id != productId).toSet()
      : {...state, productId};
}

/// For the heart button: rebuilds only when this product changes state.
final isFavoriteProvider = Provider.family<bool, String>(
  (ref, productId) => ref.watch(favoritesProvider).contains(productId),
);

/// "Sort by" of the favorite screen. The design shows "Price: lowest to high".
final favoritesSortProvider =
    NotifierProvider<FavoritesSortNotifier, ProductSort>(
      FavoritesSortNotifier.new,
    );

class FavoritesSortNotifier extends Notifier<ProductSort> {
  @override
  ProductSort build() => ProductSort.priceLowToHigh;

  void select(ProductSort sort) => state = sort;
}

final favoriteProductsProvider = Provider<List<Product>>((ref) {
  final ids = ref.watch(favoritesProvider);
  return ref
      .watch(productRepositoryProvider)
      .getByIds(ids)
      .sortedBy(ref.watch(favoritesSortProvider));
});
