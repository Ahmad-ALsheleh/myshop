import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/cart/presentation/providers/cart_provider.dart';
import 'package:myshop/features/checkout/data/mock/mock_delivery_methods.dart';
import 'package:myshop/features/checkout/presentation/providers/checkout_provider.dart';
import 'package:myshop/features/profile/data/mock/mock_addresses.dart';
import 'package:myshop/features/profile/data/mock/mock_orders.dart';
import 'package:myshop/features/profile/data/mock/mock_payment_cards.dart';
import 'package:myshop/features/profile/data/repositories/order_repository.dart';
import 'package:myshop/features/profile/presentation/providers/orders_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer.test(
      overrides: [
        orderRepositoryProvider.overrideWithValue(
          OrderRepository(latency: Duration.zero),
        ),
      ],
    );
  });

  test('summary matches the design: \$239.98 + \$18 = \$257.98', () {
    final summary = container.read(orderSummaryProvider);

    expect(summary.itemsTotal, 23998);
    expect(summary.deliveryFee, 1800);
    expect(summary.total, 25798);
  });

  test('choosing another delivery method updates the total', () {
    container.read(checkoutProvider.notifier).selectDeliveryMethod(dhl);

    expect(container.read(orderSummaryProvider).total, 23998 + 1500);
  });

  test('placing an order saves it and empties the cart', () async {
    final order = await container.read(checkoutProvider.notifier).placeOrder();

    expect(order, isNotNull);
    expect(order!.summary.total, 25798);
    expect(order.address, homeAddress);
    expect(order.paymentCard, mastercard);
    expect(order.deliveryMethod, fedEx);
    expect(container.read(ordersProvider).first, order);
    expect(container.read(ordersProvider), hasLength(mockOrders.length + 1));
    expect(container.read(cartProvider), isEmpty);
    expect(container.read(checkoutProvider).isPlacingOrder, isFalse);
  });

  test('an empty cart cannot be ordered', () async {
    container.read(cartProvider.notifier).clear();

    expect(
      await container.read(checkoutProvider.notifier).placeOrder(),
      isNull,
    );
    expect(container.read(ordersProvider), hasLength(mockOrders.length));
  });
}
