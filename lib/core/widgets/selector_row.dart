import 'package:flutter/widgets.dart';

import '../theme/app_dimens.dart';

/// Lays out square cells on the 6-column grid of the design (sizes, colors,
/// filter swatches): cells keep the same size even when there are fewer
/// than 6, and wrap to a new line when there are more.
class SelectorRow extends StatelessWidget {
  const SelectorRow({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  static const _columns = 6;

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cell =
            (constraints.maxWidth - AppSizes.selectorGap * (_columns - 1)) /
            _columns;
        return Wrap(
          spacing: AppSizes.selectorGap,
          runSpacing: AppSizes.selectorGap,
          children: [
            for (var i = 0; i < itemCount; i++)
              SizedBox.square(dimension: cell, child: itemBuilder(context, i)),
          ],
        );
      },
    );
  }
}
