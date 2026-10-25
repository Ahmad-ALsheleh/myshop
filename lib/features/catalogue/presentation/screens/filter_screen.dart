import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/options_sheet.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/select_field.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/data/models/product_size.dart';
import '../../../product/data/models/product_sort.dart';
import '../../../product/presentation/widgets/product_sort_bar.dart';
import '../../../product/presentation/widgets/size_selector.dart';
import '../../data/models/category.dart';
import '../../data/models/product_filter.dart';
import '../providers/catalogue_providers.dart';
import '../providers/product_filter_provider.dart';
import '../widgets/color_swatch_selector.dart';
import '../widgets/price_range_input.dart';

/// Filter of the items screen, as one reactive form. "Results (n)" counts
/// live and applies the form; the back arrow leaves without applying.
class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  static const _min = 'minPrice';
  static const _max = 'maxPrice';
  static const _subcategory = 'subcategory';
  static const _brands = 'brands';
  static const _colors = 'colors';
  static const _sizes = 'sizes';
  static const _sort = 'sort';
  static const _limit = ProductFilter.maxPriceLimit ~/ 100;

  late final ProductFilter _applied = ref.read(
    productFilterProvider(widget.categoryId),
  );

  late final _form = FormGroup(
    {
      _min: FormControl<int>(validators: [Validators.required]),
      _max: FormControl<int>(
        validators: [Validators.required, Validators.max(_limit)],
      ),
      _subcategory: FormControl<String>(),
      _brands: FormControl<Set<String>>(),
      _colors: FormControl<Set<ProductColor>>(),
      _sizes: FormControl<Set<ProductSize>>(),
      _sort: FormControl<ProductSort>(),
    },
    validators: [_priceOrder],
  );

  static final _priceOrder = Validators.delegate((control) {
    final form = control as FormGroup;
    final min = form.control(_min).value as int?;
    final max = form.control(_max).value as int?;
    return min != null && max != null && min > max
        ? {'priceOrder': true}
        : null;
  });

  @override
  void initState() {
    super.initState();
    _fill(_applied);
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _fill(ProductFilter filter) => _form.value = {
    _min: filter.minPrice ~/ 100,
    _max: filter.maxPrice ~/ 100,
    _subcategory: filter.subcategoryId,
    _brands: filter.brands,
    _colors: filter.colors,
    _sizes: filter.sizes,
    _sort: filter.sort,
  };

  ProductFilter get _draft {
    T value<T>(String name) => _form.control(name).value as T;
    return ProductFilter(
      query: _applied.query,
      subcategoryId: value<String?>(_subcategory),
      minPrice: (value<int?>(_min) ?? 0) * 100,
      maxPrice: (value<int?>(_max) ?? _limit) * 100,
      brands: value<Set<String>?>(_brands) ?? const {},
      colors: value<Set<ProductColor>?>(_colors) ?? const {},
      sizes: value<Set<ProductSize>?>(_sizes) ?? const {},
      sort: value<ProductSort?>(_sort) ?? ProductSort.featured,
    );
  }

  void _toggle<T>(String name, T item) {
    final control = _form.control(name) as FormControl<Set<T>>;
    final current = control.value ?? <T>{};
    control.value = current.contains(item)
        ? ({...current}..remove(item))
        : {...current, item};
  }

  void _apply() {
    ref.read(productFilterProvider(widget.categoryId).notifier).apply(_draft);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final category = ref.watch(categoryProvider(widget.categoryId));
    final products = ref.watch(allCategoryProductsProvider(widget.categoryId));
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    Widget section(String label, Widget child) => Padding(
      padding: const EdgeInsetsDirectional.only(bottom: ShopDimens.sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: ShopDimens.labelToField,
        children: [
          Text(label, style: labelStyle),
          child,
        ],
      ),
    );

    return ReactiveForm(
      formGroup: _form,
      child: Scaffold(
        body: Column(
          children: [
            GradientHeader(
              title: l10n.filter,
              trailing: HeaderTextButton(
                label: l10n.clear,
                onPressed: () => _fill(ProductFilter(query: _applied.query)),
              ),
            ),
            Expanded(
              child: ReactiveFormConsumer(
                builder: (context, form, _) {
                  final draft = _draft;
                  return ListView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.m,
                      ShopDimens.formTop,
                      AppSpacing.m,
                      0,
                    ),
                    children: [
                      section(
                        l10n.priceLabel,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: AppSpacing.xs),
                            const PriceRangeInput(
                              minControlName: _min,
                              maxControlName: _max,
                              limit: _limit,
                            ),
                            if (form.hasError('priceOrder'))
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.xs,
                                ),
                                child: Text(
                                  l10n.priceRangeInvalid,
                                  style: AppTextStyles.caption.copyWith(
                                    color: palette.sale,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      section(
                        l10n.categoriesLabel,
                        _SubcategoryField(
                          subcategories: category?.subcategories ?? const [],
                          selectedId: draft.subcategoryId,
                          onSelected: (id) =>
                              _form.control(_subcategory).value = id,
                        ),
                      ),
                      section(
                        l10n.brandLabel,
                        SelectField(
                          value: draft.brands.isEmpty
                              ? l10n.all
                              : draft.brands.join(', '),
                          onTap: () async {
                            final brands = await showMultiOptionsSheet(
                              context,
                              title: l10n.brandLabel,
                              options: ref.read(
                                categoryBrandsProvider(widget.categoryId),
                              ),
                              selected: draft.brands,
                              labelOf: (brand) => brand,
                              confirmLabel: l10n.done,
                            );
                            if (brands != null) {
                              _form.control(_brands).value = brands;
                            }
                          },
                        ),
                      ),
                      section(
                        l10n.colorsLabel,
                        ColorSwatchSelector(
                          colors: ref.watch(
                            categoryColorsProvider(widget.categoryId),
                          ),
                          selected: draft.colors,
                          onTap: (color) => _toggle(_colors, color),
                        ),
                      ),
                      section(
                        l10n.sizesLabel,
                        SizeSelector(
                          sizes: ProductSize.values,
                          selected: draft.sizes,
                          onTap: (size) => _toggle(_sizes, size),
                        ),
                      ),
                      section(
                        l10n.sortByLabel,
                        SelectField(
                          value: draft.sort.label(context),
                          onTap: () async {
                            final sort = await showSortSheet(
                              context,
                              draft.sort,
                            );
                            if (sort != null) _form.control(_sort).value = sort;
                          },
                        ),
                      ),
                      const SizedBox(height: ShopDimens.resultsTop),
                      PrimaryButton(
                        label: l10n.results(draft.apply(products).length),
                        onPressed: form.valid ? _apply : null,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.paddingOf(context).bottom + AppSpacing.m,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubcategoryField extends StatelessWidget {
  const _SubcategoryField({
    required this.subcategories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<Subcategory> subcategories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String labelOf(String? id) => id == null
        ? l10n.all
        : context.localize(
            subcategories
                .firstWhere((subcategory) => subcategory.id == id)
                .name,
          );

    return SelectField(
      value: labelOf(selectedId),
      onTap: () async {
        // A sentinel, because `null` (= "All") is also a valid choice.
        const all = '';
        final chosen = await showOptionsSheet<String>(
          context,
          title: l10n.categoriesLabel,
          options: [
            all,
            for (final subcategory in subcategories) subcategory.id,
          ],
          selected: selectedId ?? all,
          labelOf: (id) => labelOf(id == all ? null : id),
        );
        if (chosen != null) onSelected(chosen == all ? null : chosen);
      },
    );
  }
}
