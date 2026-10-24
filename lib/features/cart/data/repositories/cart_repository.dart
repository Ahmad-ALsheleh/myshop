import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_cart.dart';
import '../models/cart_item.dart';

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) => CartRepository(),
);

class CartRepository {
  /// The cart the app starts with.
  List<CartItem> loadItems() => mockCartItems;
}
