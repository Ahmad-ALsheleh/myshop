import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
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

  for (final (name, prefs) in [
    (
      'gallery_light_en',
      <String, Object>{'theme_mode': 'light', 'locale': 'en'},
    ),
    ('gallery_dark_ar', <String, Object>{'theme_mode': 'dark', 'locale': 'ar'}),
  ]) {
    testWidgets(name, skip: !_enabled, (tester) async {
      await _render(tester, name, prefs, height: 1900);
    });
  }
}

Future<void> _render(
  WidgetTester tester,
  String name,
  Map<String, Object> prefs, {
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

  // flutter_test draws shadows without blur unless told otherwise; it must
  // be restored before the test ends.
  debugDisableShadows = false;

  await tester.pumpWidget(
    RepaintBoundary(
      key: boundary,
      child: ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        child: const MyShopApp(),
      ),
    ),
  );
  await tester.pump();

  await tester.runAsync(() async {
    for (final element in find.byType(Image).evaluate()) {
      await precacheImage((element.widget as Image).image, element);
    }
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
