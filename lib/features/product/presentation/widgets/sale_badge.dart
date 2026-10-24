import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "-50%" tag glued to the start edge of the product image.
class SaleBadge extends StatelessWidget {
  const SaleBadge({super.key, required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      width: AppSizes.saleBadgeWidth,
      height: AppSizes.saleBadgeHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: palette.saleBadgeGradient,
        borderRadius: const BorderRadiusDirectional.horizontal(
          end: Radius.circular(AppSizes.saleBadgeHeight / 2),
        ),
      ),
      child: Text(
        context.l10n.discountBadge(percent),
        // Keeps "-50%" in this order in Arabic too.
        textDirection: TextDirection.ltr,
        style: AppTextStyles.caption.copyWith(
          color: palette.onAccent,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
