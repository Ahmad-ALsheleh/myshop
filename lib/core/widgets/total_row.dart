import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_text_styles.dart';
import '../utils/price_formatter.dart';

/// "Total price ........ $239.98" (cart and checkout panels).
class TotalRow extends StatelessWidget {
  const TotalRow({super.key, required this.label, required this.amount});

  final String label;

  /// In cents.
  final int amount;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.headline.copyWith(color: palette.textPrimary),
          ),
        ),
        Text(
          formatPrice(amount),
          style: AppTextStyles.priceLarge.copyWith(color: palette.textPrimary),
        ),
      ],
    );
  }
}
