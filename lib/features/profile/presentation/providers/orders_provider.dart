import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';

/// Order history, newest first.
final ordersProvider = NotifierProvider<OrdersNotifier, List<Order>>(
  OrdersNotifier.new,
);

class OrdersNotifier extends Notifier<List<Order>> {
  @override
  List<Order> build() => ref.watch(orderRepositoryProvider).loadOrders();

  void add(Order order) => state = [order, ...state];
}
