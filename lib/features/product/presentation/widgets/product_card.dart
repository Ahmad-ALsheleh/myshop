import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/product.dart';
import 'favorite_button.dart';
import 'product_price.dart';
import 'rating_stars.dart';
import 'sale_badge.dart';

/// Product tile of the home, items, favorite and product pages.
///
/// The width comes from the parent (grid cell or list item); the image is
/// square. Use [ProductCard.heightFor] to size grid rows.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  static const _nameLines = 2;

  /// Total height of a card [width] wide (image + texts), for grids.
  static double heightFor(double width, TextScaler textScaler) {
    double line(TextStyle style) =>
        textScaler.scale(style.fontSize!) * style.height!;
    return width +
        AppSpacing.imageToStars +
        AppSizes.starIcon +
        AppSpacing.starsToName +
        line(AppTextStyles.body) * _nameLines +
        AppSpacing.nameToPrice +
        line(AppTextStyles.price);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final nameHeight =
        MediaQuery.textScalerOf(context).scale(AppTextStyles.body.fontSize!) *
        AppTextStyles.body.height! *
        _nameLines;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The heart is centred on the bottom edge of the image; the stars
          // are part of the stack so the heart stays inside its bounds
          // (and stays tappable).
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductImage(product: product),
                  const SizedBox(height: AppSpacing.imageToStars),
                  RatingStars(rating: product.rating),
                ],
              ),
              PositionedDirectional(
                end: AppSpacing.heartButtonEnd,
                bottom:
                    AppSizes.starIcon +
                    AppSpacing.imageToStars -
                    AppSizes.heartButton / 2,
                child: FavoriteButton.circle(productId: product.id),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.starsToName),
          SizedBox(
            height: nameHeight,
            child: Text(
              context.localize(product.name),
              style: AppTextStyles.body.copyWith(color: palette.textPrimary),
              maxLines: _nameLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppSpacing.nameToPrice),
          ProductPrice(product: product),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xs),
            child: Image.asset(product.thumbnail, fit: BoxFit.cover),
          ),
          if (product.isOnSale)
            PositionedDirectional(
              start: 0,
              top: AppSpacing.saleBadgeTop,
              child: SaleBadge(percent: product.discountPercent),
            ),
        ],
      ),
    );
  }
}
