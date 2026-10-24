import '../../../cart/data/models/cart_item.dart';
import '../../../checkout/data/mock/mock_delivery_methods.dart';
import '../../../product/data/mock/mock_products.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../models/order.dart';
import 'mock_addresses.dart';
import 'mock_payment_cards.dart';

/// Past orders, newest first.
final mockOrders = <Order>[
  Order(
    id: 'o3',
    number: '1947036',
    createdAt: DateTime(2026, 10, 21),
    items: const [
      CartItem(
        product: larkRoJeggings,
        color: ProductColor.black,
        size: ProductSize.m,
        quantity: 2,
      ),
    ],
    address: homeAddress,
    paymentCard: mastercard,
    deliveryMethod: fedEx,
  ),
  Order(
    id: 'o2',
    number: '1947035',
    createdAt: DateTime(2026, 10, 15),
    items: const [CartItem(product: novaSmartphone, color: ProductColor.blue)],
    address: workAddress,
    paymentCard: visa,
    deliveryMethod: dhl,
    status: OrderStatus.shipped,
  ),
  Order(
    id: 'o1',
    number: '1947034',
    createdAt: DateTime(2026, 10, 2),
    items: const [
      CartItem(
        product: saodimallsuTurtleneck,
        color: ProductColor.beige,
        size: ProductSize.m,
      ),
      CartItem(
        product: ecowishKimono,
        color: ProductColor.orange,
        size: ProductSize.s,
      ),
    ],
    address: homeAddress,
    paymentCard: mastercard,
    deliveryMethod: usps,
    status: OrderStatus.delivered,
  ),
];
