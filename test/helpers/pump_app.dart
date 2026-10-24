import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/forms/validation_messages.dart';
import 'package:myshop/core/theme/app_theme.dart';
import 'package:myshop/l10n/generated/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

extension PumpApp on WidgetTester {
  /// Pumps [child] with the app theme, translations and form messages.
  /// Returns the provider container to read/modify state in tests.
  Future<ProviderContainer> pumpApp(
    Widget child, {
    Locale locale = const Locale('en'),
  }) async {
    final container = ProviderContainer.test();
    await pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) => ReactiveFormConfig(
            validationMessages: appValidationMessages(
              AppLocalizations.of(context),
            ),
            child: child!,
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
    return container;
  }
}
