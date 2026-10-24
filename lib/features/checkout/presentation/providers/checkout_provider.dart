import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/data/models/cart_item.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../profile/data/models/order.dart';
import '../../../profile/data/repositories/order_repository.dart';
import '../../../profile/presentation/providers/addresses_provider.dart';
import '../../../profile/presentation/providers/orders_provider.dart';
import '../../../profile/presentation/providers/payment_cards_provider.dart';
import '../../data/models/delivery_method.dart';
import '../../data/models/order_summary.dart';
import '../../data/repositories/delivery_repository.dart';

final deliveryMethodsProvider = Provider<List<DeliveryMethod>>(
  (ref) => ref.watch(deliveryRepositoryProvider).getAll(),
);

@immutable
class CheckoutState {
  const CheckoutState({
    required this.deliveryMethod,
    this.isPlacingOrder = false,
  });

  final DeliveryMethod deliveryMethod;

  /// True while the fake payment runs ("Pay" shows a loader).
  final bool isPlacingOrder;

  CheckoutState copyWith({
    DeliveryMethod? deliveryMethod,
    bool? isPlacingOrder,
  }) => CheckoutState(
    deliveryMethod: deliveryMethod ?? this.deliveryMethod,
    isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
  );
}

final checkoutProvider = NotifierProvider<CheckoutNotifier, CheckoutState>(
  CheckoutNotifier.new,
);

class CheckoutNotifier extends Notifier<CheckoutState> {
  @override
  CheckoutState build() => CheckoutState(
    deliveryMethod: ref.watch(deliveryRepositoryProvider).getDefault(),
  );

  void selectDeliveryMethod(DeliveryMethod method) =>
      state = state.copyWith(deliveryMethod: method);

  /// Pays for the cart: saves the order and empties the cart.
  ///
  /// Returns `null` (and does nothing) when the order cannot be placed: empty
  /// cart, no address or card, or a payment already running.
  Future<Order?> placeOrder() async {
    final items = ref.read(cartProvider);
    final address = ref.read(selectedAddressProvider);
    final card = ref.read(selectedPaymentCardProvider);
    if (items.isEmpty ||
        address == null ||
        card == null ||
        state.isPlacingOrder) {
      return null;
    }

    state = state.copyWith(isPlacingOrder: true);
    try {
      final order = await ref
          .read(orderRepositoryProvider)
          .placeOrder(
            items: items,
            address: address,
            paymentCard: card,
            deliveryMethod: state.deliveryMethod,
          );
      if (!ref.mounted) return order;
      ref.read(ordersProvider.notifier).add(order);
      ref.read(cartProvider.notifier).clear();
      return order;
    } finally {
      if (ref.mounted) state = state.copyWith(isPlacingOrder: false);
    }
  }
}

/// "Items / Delivery / Total price" of the checkout screen.
final orderSummaryProvider = Provider<OrderSummary>(
  (ref) => OrderSummary(
    itemsTotal: ref.watch(cartProvider).totalPrice,
    deliveryFee: ref.watch(
      checkoutProvider.select((checkout) => checkout.deliveryMethod.price),
    ),
  ),
);
