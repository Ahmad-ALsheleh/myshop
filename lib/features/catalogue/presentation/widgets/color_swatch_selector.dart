import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/selector_row.dart';
import '../../../product/data/models/product_color.dart';
import '../../../product/presentation/widgets/product_color_label.dart';

/// Round color dots of the filter screen; selected ones get a yellow ring.
class ColorSwatchSelector extends StatelessWidget {
  const ColorSwatchSelector({
    super.key,
    required this.colors,
    required this.selected,
    required this.onTap,
  });

  final List<ProductColor> colors;
  final Set<ProductColor> selected;
  final ValueChanged<ProductColor> onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SelectorRow(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        final isSelected = selected.contains(color);
        return Semantics(
          button: true,
          selected: isSelected,
          label: color.label(context),
          child: GestureDetector(
            onTap: () => onTap(color),
            child: AnimatedContainer(
              duration: kThemeChangeDuration,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: AppSizes.selectedBorder,
                  color: isSelected ? palette.accent : Colors.transparent,
                ),
              ),
              child: Container(
                width: AppSizes.colorDot,
                height: AppSizes.colorDot,
                decoration: BoxDecoration(
                  color: color.swatch,
                  shape: BoxShape.circle,
                  // Light swatches (white, beige) need an outline.
                  border: Border.all(color: palette.border),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
