import 'package:flutter/foundation.dart';

/// The "Items / Delivery / Total price" block of checkout and order details.
@immutable
class OrderSummary {
  const OrderSummary({required this.itemsTotal, required this.deliveryFee});

  /// In cents.
  final int itemsTotal;
  final int deliveryFee;

  int get total => itemsTotal + deliveryFee;
}
