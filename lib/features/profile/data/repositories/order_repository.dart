import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/id_generator.dart';
import '../../../cart/data/models/cart_item.dart';
import '../../../checkout/data/models/delivery_method.dart';
import '../mock/mock_orders.dart';
import '../models/address.dart';
import '../models/order.dart';
import '../models/payment_card.dart';

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(),
);

class OrderRepository {
  /// [latency] fakes the payment request so the "Pay" button can show its
  /// loading state. Tests pass [Duration.zero].
  OrderRepository({this.latency = const Duration(milliseconds: 1200)});

  final Duration latency;

  /// The order history the app starts with, newest first.
  List<Order> loadOrders() => mockOrders;

  /// Pretends to send the order to a server and returns the created order.
  Future<Order> placeOrder({
    required List<CartItem> items,
    required Address address,
    required PaymentCard paymentCard,
    required DeliveryMethod deliveryMethod,
  }) async {
    await Future<void>.delayed(latency);
    final now = DateTime.now();
    return Order(
      id: generateId(),
      // 7 digits, like the numbers of the mock orders.
      number: '${now.millisecondsSinceEpoch % 10000000}'.padLeft(7, '0'),
      createdAt: now,
      items: items,
      address: address,
      paymentCard: paymentCard,
      deliveryMethod: deliveryMethod,
    );
  }
}
