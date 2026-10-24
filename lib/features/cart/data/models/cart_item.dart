import 'package:flutter/foundation.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';

/// A product in the cart (or in a placed order) with the chosen options.
@immutable
class CartItem {
  const CartItem({
    required this.product,
    this.color,
    this.size,
    this.quantity = 1,
  });

  final Product product;
  final ProductColor? color;
  final ProductSize? size;
  final int quantity;

  int get totalPrice => product.price * quantity;

  String get image => product.imageFor(color);

  /// Same product with the same options: adding it again only raises the
  /// quantity instead of creating a second line.
  bool isSameLine(CartItem other) =>
      other.product.id == product.id &&
      other.color == color &&
      other.size == size;

  CartItem copyWith({int? quantity}) => CartItem(
    product: product,
    color: color,
    size: size,
    quantity: quantity ?? this.quantity,
  );
}

extension CartItemsTotals on Iterable<CartItem> {
  /// In cents.
  int get totalPrice => fold(0, (sum, item) => sum + item.totalPrice);

  /// Number of pieces, e.g. "2 items" on the cart pill.
  int get totalQuantity => fold(0, (sum, item) => sum + item.quantity);
}
