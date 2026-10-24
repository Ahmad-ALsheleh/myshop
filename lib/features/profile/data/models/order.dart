import 'package:flutter/foundation.dart';

import '../../../cart/data/models/cart_item.dart';
import '../../../checkout/data/models/delivery_method.dart';
import '../../../checkout/data/models/order_summary.dart';
import 'address.dart';
import 'payment_card.dart';

enum OrderStatus { processing, shipped, delivered }

/// A placed order. It keeps copies of the items, address, card and delivery
/// method as they were at payment time.
@immutable
class Order {
  const Order({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.items,
    required this.address,
    required this.paymentCard,
    required this.deliveryMethod,
    this.status = OrderStatus.processing,
  });

  final String id;

  /// Shown to the user: "Order #1947034".
  final String number;
  final DateTime createdAt;
  final List<CartItem> items;
  final Address address;
  final PaymentCard paymentCard;
  final DeliveryMethod deliveryMethod;
  final OrderStatus status;

  OrderSummary get summary => OrderSummary(
    itemsTotal: items.totalPrice,
    deliveryFee: deliveryMethod.price,
  );
}
