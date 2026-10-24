import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../catalogue/presentation/widgets/color_swatch_selector.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../../../product/presentation/widgets/color_option_selector.dart';
import '../../../product/presentation/widgets/product_card.dart';
import '../../../product/presentation/widgets/size_selector.dart';
import '../../../shell/presentation/widgets/app_bottom_navigation.dart';

/// Temporary screen showing every shared widget (Phase 3), with theme and
/// language switches. Removed once the real screens exist.
class WidgetGalleryScreen extends ConsumerStatefulWidget {
  const WidgetGalleryScreen({super.key});

  @override
  ConsumerState<WidgetGalleryScreen> createState() =>
      _WidgetGalleryScreenState();
}

class _WidgetGalleryScreenState extends ConsumerState<WidgetGalleryScreen> {
  var _tab = 0;
  var _quantity = 1;
  var _size = ProductSize.s;
  ProductColor? _color;
  final _swatches = <ProductColor>{ProductColor.black};
  final _form = FormGroup({
    'phone': FormControl<String>(validators: [Validators.required]),
    'name': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
  });

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final products = ref.watch(featuredProductsProvider);
    final cardigan = products[1];
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          GradientHeader(
            leading: HeaderIconButton(
              icon: Icons.sort,
              tooltip: l10n.appName,
              onPressed: () {},
            ),
            middle: const AppLogo(),
            trailing: HeaderIconButton(
              icon: Icons.notifications_none,
              tooltip: l10n.appName,
              onPressed: () {},
            ),
            bottom: const AppSearchField(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.m,
                AppSpacing.l,
                AppSpacing.m,
                AppSizes.navBarHeight + AppSpacing.xl,
              ),
              children: [
                const _ThemeModeSelector(),
                const SizedBox(height: AppSpacing.xs),
                const _LanguageSelector(),
                const SizedBox(height: AppSpacing.l),
                SectionHeader(title: l10n.sampleHeadline, onSeeAll: () {}),
                const SizedBox(height: AppSpacing.m),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.cardGap,
                  children: [
                    for (final product in products.take(2))
                      Expanded(child: ProductCard(product: product)),
                  ],
                ),
                const SizedBox(height: AppSpacing.l),
                Text(l10n.colorsLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.s),
                ColorOptionSelector(
                  options: cardigan.colors,
                  selected: _color ?? cardigan.colors.first.color,
                  onTap: (color) => setState(() => _color = color),
                ),
                const SizedBox(height: AppSpacing.m),
                Text(l10n.sizesLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.s),
                SizeSelector(
                  sizes: ProductSize.values,
                  selected: {_size},
                  onTap: (size) => setState(() => _size = size),
                ),
                const SizedBox(height: AppSpacing.m),
                ColorSwatchSelector(
                  colors: ProductColor.values.take(6).toList(),
                  selected: _swatches,
                  onTap: (color) => setState(
                    () => _swatches.contains(color)
                        ? _swatches.remove(color)
                        : _swatches.add(color),
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: QuantityStepper(
                    value: _quantity,
                    onIncrement: () => setState(() => _quantity++),
                    onDecrement: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                ReactiveForm(
                  formGroup: _form,
                  child: Column(
                    spacing: AppSpacing.m,
                    children: [
                      const AppTextField<String>(
                        formControlName: 'phone',
                        hintText: '(99) 999 99 99',
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        large: true,
                      ),
                      AppTextField<String>(
                        formControlName: 'name',
                        hintText: l10n.appName,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                PrimaryButton(
                  label: l10n.getStarted,
                  onPressed: _form.markAllAsTouched,
                ),
                const SizedBox(height: AppSpacing.m),
                PrimaryButton(
                  label: l10n.getStarted,
                  onPressed: () {},
                  isLoading: true,
                  size: PrimaryButtonSize.large,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _tab,
        onTabSelected: (index) => setState(() => _tab = index),
        onCartTap: () {},
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
