import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../data/models/product.dart';
import 'product_card.dart';

/// Two-column grid of product cards (home, items, favorites, search).
/// Rows are exactly as tall as a card, so nothing is clipped or stretched.
class SliverProductGrid extends StatelessWidget {
  const SliverProductGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  final List<Product> products;
  final ValueChanged<Product>? onProductTap;

  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    return SliverPadding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.m),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final cardWidth =
              (constraints.crossAxisExtent - AppSpacing.cardGap) / _columns;
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _columns,
              crossAxisSpacing: AppSpacing.cardGap,
              mainAxisSpacing: AppSpacing.cardRowGap,
              mainAxisExtent: ProductCard.heightFor(cardWidth, textScaler),
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: onProductTap == null
                    ? null
                    : () => onProductTap!(product),
              );
            },
          );
        },
      ),
    );
  }
}
