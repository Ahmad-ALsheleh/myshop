import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
import 'package:myshop/core/router/app_router.dart';
import 'package:myshop/core/router/app_routes.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/load_fonts.dart';

/// Opens every screen on a small phone (320 x 568) and with large text
/// (375 x 812, 130%), in English and Arabic, with the real fonts.
/// Any overflow or layout error fails the test.
void main() {
  setUpAll(loadAppFonts);

  const signedIn = {'onboarding_seen': true, 'session_phone': '+380991234567'};
  final screens = <(String, Map<String, Object>)>[
    (AppRoutes.onboarding, {}),
    (AppRoutes.phone, {'onboarding_seen': true}),
    (AppRoutes.verificationOf('+380991234567'), {'onboarding_seen': true}),
    for (final route in [
      AppRoutes.home,
      AppRoutes.catalogue,
      AppRoutes.categoryItemsOf('womens-fashion'),
      AppRoutes.favorites,
      AppRoutes.profile,
      AppRoutes.search,
      AppRoutes.productOf('p2'),
      AppRoutes.productOf('p16'),
      AppRoutes.filterOf('womens-fashion'),
      AppRoutes.cart,
      AppRoutes.checkout,
      AppRoutes.orders,
      AppRoutes.settings,
      AppRoutes.addresses,
      AppRoutes.addressFormOf('a1'),
      AppRoutes.paymentMethods,
      AppRoutes.cardForm,
    ])
      (route, signedIn),
  ];
  final devices = [
    ('small', const Size(320, 568), 1.0),
    ('large text', const Size(375, 812), 1.3),
  ];

  for (final locale in ['en', 'ar']) {
    for (final (device, size, textScale) in devices) {
      for (final (route, prefs) in screens) {
        testWidgets('$locale · $device · $route', (tester) async {
          tester.view
            ..devicePixelRatio = 2
            ..physicalSize = size * 2
            ..padding = const FakeViewPadding(top: 40, bottom: 40);
          tester.platformDispatcher.textScaleFactorTestValue = textScale;
          addTearDown(tester.view.reset);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

          SharedPreferences.setMockInitialValues({'locale': locale, ...prefs});
          final container = ProviderContainer.test(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(
                await SharedPreferences.getInstance(),
              ),
            ],
          );
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: const MyShopApp(),
            ),
          );
          await tester.pump();
          container.read(appRouterProvider).go(route);
          for (var i = 0; i < 4; i++) {
            await tester.pump(const Duration(milliseconds: 300));
          }
          expect(tester.takeException(), isNull);
        });
      }
    }
  }
}
