import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/selector_row.dart';
import '../../data/models/product_size.dart';

/// "XXS XS S M L XL" squares. Single choice on the product page, several
/// on the filter screen: the parent decides through [selected].
class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onTap,
  });

  final List<ProductSize> sizes;
  final Set<ProductSize> selected;
  final ValueChanged<ProductSize> onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SelectorRow(
      itemCount: sizes.length,
      itemBuilder: (context, index) {
        final size = sizes[index];
        final isSelected = selected.contains(size);
        return Semantics(
          button: true,
          selected: isSelected,
          child: GestureDetector(
            onTap: () => onTap(size),
            child: AnimatedContainer(
              duration: kThemeChangeDuration,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? palette.accent : palette.surface,
                borderRadius: BorderRadius.circular(AppRadius.s),
                border: Border.all(
                  color: isSelected ? palette.accent : palette.border,
                ),
              ),
              child: Text(
                size.label,
                style: AppTextStyles.body.copyWith(
                  color: isSelected ? palette.onAccent : palette.textBody,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
