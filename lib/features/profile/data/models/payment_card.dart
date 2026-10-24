import 'package:flutter/foundation.dart';

import 'defaultable.dart';

enum CardNetwork { mastercard, visa }

/// A saved card. Only the last 4 digits are kept, like a real app would.
@immutable
class PaymentCard implements Defaultable<PaymentCard> {
  const PaymentCard({
    required this.id,
    required this.network,
    required this.holderName,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    this.isDefault = false,
  });

  @override
  final String id;
  final CardNetwork network;
  final String holderName;
  final String last4;
  final int expiryMonth;
  final int expiryYear;

  @override
  final bool isDefault;

  @override
  PaymentCard copyWithDefault(bool isDefault) => PaymentCard(
    id: id,
    network: network,
    holderName: holderName,
    last4: last4,
    expiryMonth: expiryMonth,
    expiryYear: expiryYear,
    isDefault: isDefault,
  );
}
