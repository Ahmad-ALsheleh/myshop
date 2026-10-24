import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';

/// Five stars with halves (4.5 → ★★★★⯪).
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = AppSizes.starIcon,
    this.spacing = AppSpacing.starGap,
  });

  final double rating;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      label: context.l10n.ratingLabel(rating.toStringAsFixed(1)),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: spacing,
        children: [
          for (var i = 1; i <= 5; i++)
            Icon(
              rating >= i
                  ? Icons.star_rounded
                  : (rating >= i - 0.5
                        ? Icons.star_half_rounded
                        : Icons.star_outline_rounded),
              size: size,
              color: palette.rating,
            ),
        ],
      ),
    );
  }
}
