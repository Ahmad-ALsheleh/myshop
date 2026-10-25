import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
import 'package:myshop/core/router/app_router.dart';
import 'package:myshop/core/router/app_routes.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:myshop/features/cart/presentation/providers/cart_provider.dart';
import 'package:myshop/features/checkout/presentation/widgets/success_dialog.dart';
import 'package:myshop/features/profile/data/mock/mock_orders.dart';
import 'package:myshop/features/profile/data/repositories/order_repository.dart';
import 'package:myshop/features/profile/presentation/providers/orders_provider.dart';
import 'package:myshop/features/profile/presentation/screens/orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('product → add to cart → checkout → pay → orders', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 2
      ..physicalSize = const Size(750, 1624);
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({
      'locale': 'en',
      'onboarding_seen': true,
      'guest_mode': true,
    });
    final container = ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
        orderRepositoryProvider.overrideWithValue(
          OrderRepository(latency: Duration.zero),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const MyShopApp()),
    );
    await tester.pump();

    Future<void> frames() async {
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }
    }

    final router = container.read(appRouterProvider);
    router.push(AppRoutes.productOf('p5'));
    await frames();

    // Product page bar → sheet; the sheet needs a size before adding.
    await tester.tap(find.text('Add to Cart'));
    await frames();
    await tester.tap(find.text('M').last);
    await tester.pump();
    await tester.tap(find.text('Add to Cart').last);
    await frames();
    expect(container.read(cartProvider), hasLength(3));

    router.push(AppRoutes.cart);
    await frames();
    await tester.tap(find.text('Check Out'));
    await frames();
    await tester.tap(find.text('Pay'));
    await frames();
    expect(find.byType(SuccessDialog), findsOneWidget);
    expect(container.read(cartProvider), isEmpty);

    await tester.tap(find.text('Go to Orders'));
    await frames();
    expect(find.byType(OrdersScreen), findsOneWidget);
    expect(container.read(ordersProvider), hasLength(mockOrders.length + 1));
  });
}
