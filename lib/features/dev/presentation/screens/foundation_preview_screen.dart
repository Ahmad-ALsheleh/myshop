import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_mode_provider.dart';

/// Temporary screen to verify Phase 1 (theme, fonts, l10n, RTL).
/// It will be removed once the real screens exist.
class FoundationPreviewScreen extends ConsumerWidget {
  const FoundationPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            _Header(title: l10n.foundationPreviewTitle),
            Expanded(
              child: ListView(
                padding: const EdgeInsetsDirectional.all(AppSpacing.m),
                children: [
                  Text(l10n.appearanceLabel, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  const _ThemeModeSelector(),
                  const SizedBox(height: AppSpacing.l),
                  Text(l10n.languageLabel, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  const _LanguageSelector(),
                  const SizedBox(height: AppSpacing.l),
                  Text(l10n.colorsLabel, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  const _ColorSwatches(),
                  const SizedBox(height: AppSpacing.l),
                  Text(l10n.typographyLabel, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.sampleHeadline, style: AppTextStyles.headline),
                  Text(l10n.sampleProductName, style: AppTextStyles.body),
                  const Text(r'$89.99', style: AppTextStyles.price),
                  Text(
                    l10n.appName,
                    style: AppTextStyles.logo.copyWith(color: palette.accent),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Text(l10n.directionLabel, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const BackButtonIcon(),
                      const SizedBox(width: AppSpacing.xs),
                      Text(l10n.directionStart),
                      const Spacer(),
                      Text(l10n.directionEnd),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.l),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(l10n.getStarted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: palette.brandGradient),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: AppSizes.toolbarHeight,
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.title.copyWith(color: palette.onAccent),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeModeSelector extends ConsumerWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(value: ThemeMode.system, label: Text(l10n.themeSystem)),
        ButtonSegment(value: ThemeMode.light, label: Text(l10n.themeLight)),
        ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
      ],
      selected: {ref.watch(themeModeProvider)},
      onSelectionChanged: (selection) =>
          ref.read(themeModeProvider.notifier).setThemeMode(selection.single),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  static const _system = 'system';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final current = ref.watch(localeProvider)?.languageCode ?? _system;
    return SegmentedButton<String>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(value: _system, label: Text(l10n.languageSystem)),
        ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
        ButtonSegment(value: 'ar', label: Text(l10n.languageArabic)),
      ],
      selected: {current},
      onSelectionChanged: (selection) {
        final code = selection.single;
        ref
            .read(localeProvider.notifier)
            .setLocale(code == _system ? null : Locale(code));
      },
    );
  }
}

class _ColorSwatches extends StatelessWidget {
  const _ColorSwatches();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final colors = [
      p.background,
      p.surface,
      p.textPrimary,
      p.textBody,
      p.textSecondary,
      p.border,
      p.accent,
      p.sale,
      p.rating,
      p.success,
    ];
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            gradient: p.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.s),
          ),
        ),
        for (final color in colors)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppRadius.s),
              border: Border.all(color: p.border),
            ),
          ),
      ],
    );
  }
}
