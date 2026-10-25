import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/menu_tile.dart';

/// Theme and language (not in the design: profile menu style).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(localeProvider)?.languageCode;
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    Widget option({
      required IconData icon,
      required String label,
      required bool selected,
      required VoidCallback onTap,
    }) => MenuTile(
      icon: icon,
      label: label,
      onTap: onTap,
      trailing: selected ? Icon(Icons.check, color: palette.accent) : null,
    );

    final setTheme = ref.read(themeModeProvider.notifier).setThemeMode;
    final setLocale = ref.read(localeProvider.notifier).setLocale;

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(title: l10n.settings),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.m),
              children: [
                Text(l10n.appearanceLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.s),
                for (final (mode, icon, label) in [
                  (
                    ThemeMode.system,
                    Icons.brightness_auto_outlined,
                    l10n.themeSystem,
                  ),
                  (ThemeMode.light, Icons.light_mode_outlined, l10n.themeLight),
                  (ThemeMode.dark, Icons.dark_mode_outlined, l10n.themeDark),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s),
                    child: option(
                      icon: icon,
                      label: label,
                      selected: themeMode == mode,
                      onTap: () => setTheme(mode),
                    ),
                  ),
                const SizedBox(height: AppSpacing.l),
                Text(l10n.languageLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.s),
                for (final (code, label) in [
                  (null, l10n.languageSystem),
                  ('en', l10n.languageEnglish),
                  ('ar', l10n.languageArabic),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s),
                    child: option(
                      icon: Icons.language,
                      label: label,
                      selected: language == code,
                      onTap: () =>
                          setLocale(code == null ? null : Locale(code)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
