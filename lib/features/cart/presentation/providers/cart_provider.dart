import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../../data/models/cart_item.dart';
import '../../data/repositories/cart_repository.dart';

/// Cart lines. Totals come from the [CartItemsTotals] extension:
/// `ref.watch(cartProvider).totalPrice`.
final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => ref.watch(cartRepositoryProvider).loadItems();

  /// Adds a new line, or raises the quantity of the same product+options.
  void add(
    Product product, {
    ProductColor? color,
    ProductSize? size,
    int quantity = 1,
  }) {
    final item = CartItem(
      product: product,
      color: color,
      size: size,
      quantity: quantity,
    );
    final exists = state.any(item.isSameLine);
    state = exists
        ? _updated(item, (line) => line.quantity + quantity)
        : [...state, item];
  }

  void increment(CartItem item) =>
      state = _updated(item, (line) => line.quantity + 1);

  /// Stops at 1: removing a line is done with "Delete", not the stepper.
  void decrement(CartItem item) => state = _updated(
    item,
    (line) => line.quantity > 1 ? line.quantity - 1 : 1,
  );

  void remove(CartItem item) =>
      state = state.where((line) => !line.isSameLine(item)).toList();

  void clear() => state = const [];

  List<CartItem> _updated(CartItem item, int Function(CartItem) quantity) => [
    for (final line in state)
      line.isSameLine(item) ? line.copyWith(quantity: quantity(line)) : line,
  ];
}
