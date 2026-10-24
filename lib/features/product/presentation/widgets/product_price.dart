import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../data/models/product.dart';

/// Price of a product; on sale it turns red and shows the crossed-out old
/// price next to it ("$49 $99").
class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.product,
    this.style = AppTextStyles.price,
  });

  final Product product;

  /// [AppTextStyles.price] on cards, [AppTextStyles.priceLarge] on the
  /// product page.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          formatPrice(product.price),
          style: style.copyWith(
            color: product.isOnSale ? palette.sale : palette.textPrimary,
          ),
        ),
        if (product.oldPrice case final oldPrice?) ...[
          const SizedBox(width: AppSpacing.oldPriceGap),
          Text(
            formatPrice(oldPrice),
            style: AppTextStyles.bodySmall.copyWith(
              color: palette.textSecondary,
              decoration: TextDecoration.lineThrough,
              decorationColor: palette.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
