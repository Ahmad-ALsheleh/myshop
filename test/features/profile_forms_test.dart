import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
import 'package:myshop/core/l10n/locale_provider.dart';
import 'package:myshop/core/router/app_router.dart';
import 'package:myshop/core/router/app_routes.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:myshop/features/profile/data/models/payment_card.dart';
import 'package:myshop/features/profile/presentation/providers/payment_cards_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ProviderContainer container;

  Future<void> frames(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }
  }

  Future<void> open(WidgetTester tester, String location) async {
    tester.view
      ..devicePixelRatio = 2
      ..physicalSize = const Size(750, 1624);
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({
      'locale': 'en',
      'onboarding_seen': true,
      'guest_mode': true,
    });
    container = ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const MyShopApp()),
    );
    await tester.pump();
    container.read(appRouterProvider).push(location);
    await frames(tester);
  }

  testWidgets('a card is validated, then saved with its last 4 digits only', (
    tester,
  ) async {
    await open(tester, AppRoutes.cardForm);
    final fields = find.byType(TextField);

    await tester.enterText(fields.at(0), '1234 5678 9012 3456');
    await tester.enterText(fields.at(1), 'Test User');
    await tester.enterText(fields.at(2), '1299');
    await tester.enterText(fields.at(3), '123');
    await tester.tap(find.text('Save'));
    await frames(tester);
    expect(find.text('Enter a valid Visa or Mastercard number'), findsOneWidget);

    await tester.enterText(fields.at(0), '4111111111111111');
    expect(find.text('4111 1111 1111 1111'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await frames(tester);

    final card = container.read(paymentCardsProvider).last;
    expect(card.network, CardNetwork.visa);
    expect(card.last4, '1111');
    expect((card.expiryMonth, card.expiryYear), (12, 2099));
  });

  testWidgets('settings switch the language', (tester) async {
    await open(tester, AppRoutes.settings);

    await tester.tap(find.text('العربية'));
    await frames(tester);
    expect(container.read(localeProvider), const Locale('ar'));
    expect(find.text('الإعدادات'), findsOneWidget);
  });
}
