import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import 'app_icon_button.dart';

/// Vertical "+ / count / −" control of the cart lines and the add to cart
/// sheet.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(
          icon: Icons.add_circle_outline,
          tooltip: l10n.increaseQuantity,
          onPressed: onIncrement,
        ),
        SizedBox(
          height: AppSizes.stepperCountHeight,
          child: Center(
            child: Text(
              '$value',
              style: AppTextStyles.bodySmall.copyWith(
                color: context.palette.textBody,
              ),
            ),
          ),
        ),
        _StepButton(
          icon: Icons.remove_circle_outline,
          tooltip: l10n.decreaseQuantity,
          onPressed: onDecrement,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
      size: AppSizes.icon,
      color: context.palette.textSecondary,
    );
  }
}
