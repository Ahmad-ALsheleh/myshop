import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/options_sheet.dart';
import '../../data/models/product_sort.dart';

extension ProductSortLabel on ProductSort {
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      ProductSort.featured => l10n.sortFeatured,
      ProductSort.priceLowToHigh => l10n.sortPriceLowToHigh,
      ProductSort.priceHighToLow => l10n.sortPriceHighToLow,
      ProductSort.topRated => l10n.sortTopRated,
    };
  }
}

/// "166 items ........ Sort by: Featured ⌄" (items and favorite screens).
class ProductSortBar extends StatelessWidget {
  const ProductSortBar({
    super.key,
    required this.count,
    required this.sort,
    required this.onSortChanged,
  });

  final int count;
  final ProductSort sort;
  final ValueChanged<ProductSort> onSortChanged;

  Future<void> _pickSort(BuildContext context) async {
    final selected = await showSortSheet(context, sort);
    if (selected != null) onSortChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          child: Text(
            l10n.itemsCount(count),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headline.copyWith(color: palette.textPrimary),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        const Spacer(),
        Flexible(
          flex: 3,
          child: GestureDetector(
            onTap: () => _pickSort(context),
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      children: [
                        TextSpan(text: '${l10n.sortBy} '),
                        TextSpan(
                          text: sort.label(context),
                          style: TextStyle(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: AppSizes.chevron,
                  color: palette.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Sort options sheet (sort bar and filter screen).
Future<ProductSort?> showSortSheet(
  BuildContext context,
  ProductSort selected,
) => showOptionsSheet(
  context,
  title: context.l10n.sortByLabel,
  options: ProductSort.values,
  selected: selected,
  labelOf: (sort) => sort.label(context),
);
