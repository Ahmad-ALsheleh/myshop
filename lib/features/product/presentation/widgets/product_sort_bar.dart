import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
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
    final selected = await showModalBottomSheet<ProductSort>(
      context: context,
      showDragHandle: true,
      builder: (context) => _SortSheet(selected: sort),
    );
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
        Text(
          l10n.itemsCount(count),
          style: AppTextStyles.headline.copyWith(color: palette.textPrimary),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => _pickSort(context),
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text.rich(
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
              Icon(
                Icons.keyboard_arrow_down,
                size: AppSizes.chevron,
                color: palette.textPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SortSheet extends StatelessWidget {
  const _SortSheet({required this.selected});

  final ProductSort selected;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final sort in ProductSort.values)
            ListTile(
              onTap: () => Navigator.pop(context, sort),
              title: Text(
                sort.label(context),
                style: AppTextStyles.body.copyWith(
                  color: palette.textPrimary,
                  fontWeight: sort == selected ? FontWeight.w700 : null,
                ),
              ),
              trailing: sort == selected
                  ? Icon(Icons.check, color: palette.accent)
                  : null,
            ),
        ],
      ),
    );
  }
}
