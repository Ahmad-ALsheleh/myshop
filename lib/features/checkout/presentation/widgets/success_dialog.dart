import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/text_action_button.dart';

/// "Success" popup after paying.
class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.onContinueShopping,
    required this.onGoToOrders,
  });

  final VoidCallback onContinueShopping;
  final VoidCallback onGoToOrders;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    return Dialog(
      backgroundColor: palette.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sheet),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lower half of a big purple circle, with the check mark.
          SizedBox(
            height: ShopDimens.popupCircleVisible,
            child: OverflowBox(
              maxHeight: ShopDimens.popupCircle,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: ShopDimens.popupCircle,
                height: ShopDimens.popupCircle,
                alignment: const Alignment(0, 0.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: palette.brandGradient,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: ShopDimens.popupIcon,
                  color: palette.onAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.m,
              AppSpacing.xl,
              AppSpacing.xl,
            ),
            child: Column(
              children: [
                Text(
                  l10n.success,
                  style: AppTextStyles.headline.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                Text(
                  l10n.orderSuccessMessage,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textBody,
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                PrimaryButton(
                  label: l10n.continueShopping,
                  onPressed: onContinueShopping,
                ),
                const SizedBox(height: AppSpacing.m),
                TextActionButton(
                  label: l10n.goToOrders,
                  onPressed: onGoToOrders,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
