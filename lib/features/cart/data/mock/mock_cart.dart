import '../../../product/data/mock/mock_products.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../models/cart_item.dart';

/// The cart of the design: $239.98, 2 items.
const mockCartItems = <CartItem>[
  CartItem(
    product: astylishCardigan,
    color: ProductColor.brown,
    size: ProductSize.s,
  ),
  CartItem(
    product: boriflorsDress,
    color: ProductColor.black,
    size: ProductSize.s,
  ),
];
