import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/bottom_navigation_spacer.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../providers/catalogue_providers.dart';
import '../widgets/category_card.dart';

/// List of all categories (catalogue tab).
class CatalogueScreen extends ConsumerWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: context.l10n.navCatalogue,
            // A tab has no previous page: the arrow of the design goes home.
            leading: HeaderBackButton(
              onPressed: () => context.go(AppRoutes.home),
            ),
            bottom: AppSearchField(onTap: () => context.push(AppRoutes.search)),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.m,
                CatalogueDimens.contentTop,
                AppSpacing.m,
                0,
              ),
              itemCount: categories.length + 1,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: CatalogueDimens.cardGap),
              itemBuilder: (context, index) {
                if (index == categories.length) {
                  return const BottomNavigationSpacer();
                }
                final category = categories[index];
                return CategoryCard(
                  category: category,
                  onTap: () =>
                      context.go(AppRoutes.categoryItemsOf(category.id)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
