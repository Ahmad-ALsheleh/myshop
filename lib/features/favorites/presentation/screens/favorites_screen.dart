import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/bottom_navigation_spacer.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../product/presentation/widgets/product_sort_bar.dart';
import '../../../product/presentation/widgets/sliver_product_grid.dart';
import '../providers/favorites_provider.dart';

/// Favorite tab: "5 items · Sort by" + the favorite products.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final products = ref.watch(favoriteProductsProvider);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: l10n.navFavorite,
            // A tab has no previous page: the arrow of the design goes home.
            leading: HeaderBackButton(
              onPressed: () => context.go(AppRoutes.home),
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? EmptyState(
                    icon: Icons.favorite_border,
                    message: l10n.noFavorites,
                  )
                : CustomScrollView(
                    slivers: [
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
                            sort: ref.watch(favoritesSortProvider),
                            onSortChanged: ref
                                .read(favoritesSortProvider.notifier)
                                .select,
                          ),
                        ),
                      ),
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
