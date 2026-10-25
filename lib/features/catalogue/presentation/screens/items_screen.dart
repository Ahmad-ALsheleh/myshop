import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/bottom_navigation_spacer.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../product/presentation/widgets/product_sort_bar.dart';
import '../../../product/presentation/widgets/sliver_product_grid.dart';
import '../providers/catalogue_providers.dart';
import '../providers/product_filter_provider.dart';
import '../widgets/subcategory_chips.dart';

/// Products of one category, with search, subcategory chips and sort.
class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider(categoryId));
    final filter = ref.watch(productFilterProvider(categoryId));
    final filterNotifier = ref.read(productFilterProvider(categoryId).notifier);
    final products = ref.watch(categoryProductsProvider(categoryId));

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: category == null ? null : context.localize(category.name),
            trailing: _FilterButton(
              isActive: filter.hasActiveFilters,
              // The filter screen comes in the next step.
              onPressed: null,
            ),
            bottom: AppSearchField(
              initialValue: filter.query,
              onChanged: filterNotifier.search,
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: CatalogueDimens.contentTop,
                    ),
                    child: SubcategoryChips(
                      subcategories: category?.subcategories ?? const [],
                      selectedId: filter.subcategoryId,
                      onSelected: filterNotifier.selectSubcategory,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.m,
                    CatalogueDimens.countTop,
                    AppSpacing.m,
                    CatalogueDimens.countToGrid,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ProductSortBar(
                      count: products.length,
                      sort: filter.sort,
                      onSortChanged: filterNotifier.sortBy,
                    ),
                  ),
                ),
                if (products.isEmpty)
                  SliverToBoxAdapter(
                    child: EmptyState(
                      icon: Icons.search_off,
                      message: context.l10n.noProducts,
                    ),
                  )
                else
                  SliverProductGrid(products: products, onProductTap: null),
                const SliverToBoxAdapter(child: BottomNavigationSpacer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter icon of the header; a yellow dot shows that filters are applied.
class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.isActive, required this.onPressed});

  final bool isActive;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The sliders of the design are vertical.
        RotatedBox(
          quarterTurns: 1,
          child: AppIconButton(
            icon: Icons.tune,
            tooltip: context.l10n.filter,
            onPressed: onPressed,
            size: AppSizes.headerIcon,
            color: palette.onAccent,
          ),
        ),
        if (isActive)
          PositionedDirectional(
            end: 0,
            top: 0,
            child: Container(
              width: CatalogueDimens.filterDot,
              height: CatalogueDimens.filterDot,
              decoration: BoxDecoration(
                color: palette.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
