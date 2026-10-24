import 'package:flutter/foundation.dart';

/// A shipping company option on the checkout screen (DHL, FedEx, USPS).
@immutable
class DeliveryMethod {
  const DeliveryMethod({
    required this.id,
    required this.name,
    required this.logo,
    required this.price,
    required this.minDays,
    required this.maxDays,
  });

  final String id;

  /// Company name, used for accessibility (the logo carries it visually).
  final String name;
  final String logo;

  /// In cents.
  final int price;

  /// Delivery time range: "1-2 days".
  final int minDays;
  final int maxDays;
}
