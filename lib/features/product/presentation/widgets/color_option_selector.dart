import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/selector_row.dart';
import '../../data/models/product.dart';
import '../../data/models/product_color.dart';
import 'product_color_label.dart';

/// Photo thumbnails of the product colors; the chosen one gets a yellow
/// frame (product page and add to cart sheet).
class ColorOptionSelector extends StatelessWidget {
  const ColorOptionSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onTap,
  });

  final List<ProductColorOption> options;
  final ProductColor? selected;
  final ValueChanged<ProductColor> onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final radius = BorderRadius.circular(AppRadius.s);
    return SelectorRow(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = option.color == selected;
        return Semantics(
          button: true,
          selected: isSelected,
          label: option.color.label(context),
          child: GestureDetector(
            onTap: () => onTap(option.color),
            child: AnimatedContainer(
              duration: kThemeChangeDuration,
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(
                  width: AppSizes.selectedBorder,
                  color: isSelected ? palette.accent : Colors.transparent,
                ),
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: Image.asset(option.image, fit: BoxFit.contain),
              ),
            ),
          ),
        );
      },
    );
  }
}
