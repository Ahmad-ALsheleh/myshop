import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/bottom_navigation_spacer.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../catalogue/presentation/providers/catalogue_providers.dart';
import '../../../catalogue/presentation/widgets/categories_drawer.dart';
import '../../../catalogue/presentation/widgets/category_tile.dart';
import '../../../product/presentation/widgets/sliver_product_grid.dart';
import '../providers/home_providers.dart';
import '../widgets/promo_banner_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      drawer: const CategoriesDrawer(),
      body: Column(
        children: [
          GradientHeader(
            leading: Builder(
              builder: (context) => HeaderIconButton(
                icon: Icons.sort,
                tooltip: l10n.menu,
                onPressed: Scaffold.of(context).openDrawer,
              ),
            ),
            middle: const AppLogo(),
            trailing: HeaderIconButton(
              icon: Icons.notifications_none,
              tooltip: l10n.notifications,
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n.noNotifications))),
            ),
            bottom: AppSearchField(onTap: () => context.push(AppRoutes.search)),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.m,
                    CatalogueDimens.contentTop,
                    AppSpacing.m,
                    0,
                  ),
                  sliver: SliverList.list(
                    children: [
                      PromoBannerCarousel(
                        banners: ref.watch(bannersProvider),
                        onBannerTap: (banner) => context.go(
                          AppRoutes.categoryItemsOf(banner.categoryId),
                        ),
                      ),
                      const SizedBox(height: CatalogueDimens.sectionTop),
                      SectionHeader(
                        title: l10n.navCatalogue,
                        onSeeAll: () => context.go(AppRoutes.catalogue),
                      ),
                      const SizedBox(height: CatalogueDimens.sectionToContent),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: CatalogueDimens.tileSize,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.m,
                      ),
                      itemCount: categories.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: CatalogueDimens.tileGap),
                      itemBuilder: (context, index) => CategoryTile(
                        category: categories[index],
                        onTap: () => context.go(
                          AppRoutes.categoryItemsOf(categories[index].id),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.m,
                    CatalogueDimens.featuredTop,
                    AppSpacing.m,
                    CatalogueDimens.featuredToGrid,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(title: l10n.featured),
                  ),
                ),
                SliverProductGrid(
                  products: ref.watch(featuredProductsProvider),
                  onProductTap: (product) =>
                      context.push(AppRoutes.productOf(product.id)),
                ),
                const SliverToBoxAdapter(child: BottomNavigationSpacer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
