import 'dart:io';

import 'package:flutter/services.dart';

/// Widget tests use a placeholder font unless the real ones are loaded.
Future<void> loadAppFonts() async {
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
