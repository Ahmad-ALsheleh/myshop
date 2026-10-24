import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_favorites.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepository(),
);

class FavoritesRepository {
  /// Ids of the products the app starts with as favorites.
  Set<String> loadFavoriteIds() => {...mockFavoriteIds};
}
