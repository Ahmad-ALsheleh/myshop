import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../product/presentation/widgets/sliver_product_grid.dart';
import '../providers/search_provider.dart';

/// Search in all products (opened from the home and catalogue search
/// fields). Not in the design: built with the items screen pieces.
class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: l10n.search,
            bottom: AppSearchField(
              autofocus: true,
              onChanged: ref.read(searchQueryProvider.notifier).update,
            ),
          ),
          Expanded(
            child: query.trim().isEmpty
                ? EmptyState(icon: Icons.search, message: l10n.searchPrompt)
                : results.isEmpty
                ? EmptyState(icon: Icons.search_off, message: l10n.noProducts)
                : CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(height: CatalogueDimens.contentTop),
                      ),
                      SliverProductGrid(
                        products: results,
                        onProductTap: (product) =>
                            context.push(AppRoutes.productOf(product.id)),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: AppSpacing.l),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
