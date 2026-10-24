import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/extensions/context_extensions.dart';
import 'core/l10n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_fonts.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';
import 'l10n/generated/app_localizations.dart';

class MyShopApp extends ConsumerWidget {
  const MyShopApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouterProvider),
      themeMode: ref.watch(themeModeProvider),
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // The font depends on the *resolved* locale (which may come from the
      // device), so the theme is rebuilt here where that locale is known.
      builder: (context, child) {
        final fontFamily = AppFonts.forLocale(Localizations.localeOf(context));
        return Theme(
          data: AppTheme.of(
            Theme.of(context).brightness,
            fontFamily: fontFamily,
          ),
          child: child!,
        );
      },
    );
  }
}
