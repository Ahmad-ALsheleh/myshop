import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
import 'package:myshop/core/router/app_router.dart';
import 'package:myshop/core/router/app_routes.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Renders the app at the design size (375 x 812 @2x, iPhone X insets) into
/// `build/preview/*.png`, to compare with the PNGs of the design.
///
/// Not part of the normal test run:
/// `flutter test test/preview --dart-define=PREVIEW=true`
const _enabled = bool.fromEnvironment('PREVIEW');

void main() {
  setUpAll(_loadFonts);

  const light = <String, Object>{'theme_mode': 'light', 'locale': 'en'};
  const darkAr = <String, Object>{'theme_mode': 'dark', 'locale': 'ar'};
  const inApp = <String, Object>{'onboarding_seen': true, 'guest_mode': true};
  const signedOut = <String, Object>{'onboarding_seen': true};
  const signedIn = <String, Object>{
    'onboarding_seen': true,
    'session_phone': '+380991234567',
  };

  // name, saved preferences, route (null = where the app starts), height
  final screens = <(String, Map<String, Object>, String?, double)>[
    ('home_light_en', {...light, ...inApp}, null, 812),
    ('home_full_light_en', {...light, ...inApp}, null, 1250),
    ('home_dark_ar', {...darkAr, ...inApp}, null, 812),
    ('catalogue_light_en', {...light, ...inApp}, AppRoutes.catalogue, 812),
    (
      'items_light_en',
      {...light, ...inApp},
      AppRoutes.categoryItemsOf('womens-fashion'),
      1530,
    ),
    ('favorites_light_en', {...light, ...inApp}, AppRoutes.favorites, 1100),
    ('profile_light_en', {...light, ...signedIn}, AppRoutes.profile, 812),
    ('profile_dark_ar', {...darkAr, ...signedIn}, AppRoutes.profile, 812),
    (
      'filter_light_en',
      {...light, ...inApp},
      AppRoutes.filterOf('womens-fashion'),
      830,
    ),
    ('product_light_en', {...light, ...inApp}, AppRoutes.productOf('p2'), 1612),
    ('cart_light_en', {...light, ...inApp}, AppRoutes.cart, 812),
    ('checkout_light_en', {...light, ...inApp}, AppRoutes.checkout, 812),
    ('checkout_dark_ar', {...darkAr, ...inApp}, AppRoutes.checkout, 812),
    ('addresses_light_en', {...light, ...inApp}, AppRoutes.addresses, 812),
    ('settings_dark_ar', {...darkAr, ...inApp}, AppRoutes.settings, 812),
    ('onboarding_light_en', light, null, 812),
    ('onboarding_dark_ar', darkAr, null, 812),
    ('phone_light_en', {...light, ...signedOut}, null, 812),
    ('phone_dark_ar', {...darkAr, ...signedOut}, null, 812),
    (
      'verification_light_en',
      {...light, ...signedOut},
      AppRoutes.verificationOf('+380991234567'),
      812,
    ),
  ];

  for (final (name, prefs, location, height) in screens) {
    testWidgets(name, skip: !_enabled, (tester) async {
      await _render(tester, name, prefs, location: location, height: height);
    });
  }
}

Future<void> _render(
  WidgetTester tester,
  String name,
  Map<String, Object> prefs, {
  String? location,
  double height = 812,
}) async {
  tester.view
    ..devicePixelRatio = 2
    ..physicalSize = Size(750, height * 2)
    ..padding = const FakeViewPadding(top: 88, bottom: 68);
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues(prefs);
  final preferences = await SharedPreferences.getInstance();
  final boundary = GlobalKey();
  final container = ProviderContainer.test(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
  );

  // flutter_test draws shadows without blur unless told otherwise; it must
  // be restored before the test ends.
  debugDisableShadows = false;

  await tester.pumpWidget(
    RepaintBoundary(
      key: boundary,
      child: UncontrolledProviderScope(
        container: container,
        child: const MyShopApp(),
      ),
    ),
  );
  await tester.pump();
  if (location != null) {
    container.read(appRouterProvider).go(location);
    await tester.pumpAndSettle();
  }

  await tester.runAsync(() async {
    for (final element in find.byType(Image).evaluate()) {
      await precacheImage((element.widget as Image).image, element);
    }
    // Images painted by decorations (avatars) load on their own.
    await Future<void>.delayed(const Duration(milliseconds: 300));
  });
  await tester.pump(const Duration(milliseconds: 500));

  await tester.runAsync(() async {
    final render =
        boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await render.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('build/preview/$name.png')..createSync(recursive: true);
    file.writeAsBytesSync(bytes!.buffer.asUint8List());
  });
  debugDisableShadows = true;
}

/// Widget tests use a placeholder font unless the real ones are loaded.
Future<void> _loadFonts() async {
  final families = {
    'Inter': ['Regular', 'Medium', 'SemiBold', 'Bold'],
    'Tajawal': ['Regular', 'Medium', 'Bold', 'ExtraBold'],
    'Montserrat': ['SemiBold', 'Bold'],
  };
  for (final MapEntry(key: family, value: weights) in families.entries) {
    final loader = FontLoader(family);
    for (final weight in weights) {
      loader.addFont(rootBundle.load('assets/fonts/$family-$weight.ttf'));
    }
    await loader.load();
  }

  final icons = File(
    '${Platform.environment['FLUTTER_ROOT']}/bin/cache/artifacts/'
    'material_fonts/MaterialIcons-Regular.otf',
  );
  await (FontLoader('MaterialIcons')
        ..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync()))))
      .load();
}
