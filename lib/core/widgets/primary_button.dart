import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

enum PrimaryButtonSize {
  /// 48pt: cart, checkout, filter, product page.
  regular,

  /// 64pt: sign in screens.
  large,
}

/// The yellow full-width button of the design.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.size = PrimaryButtonSize.regular,
  });

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  /// Shows a spinner and ignores taps, keeping the enabled color.
  final bool isLoading;
  final PrimaryButtonSize size;

  bool get _isLarge => size == PrimaryButtonSize.large;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SizedBox(
      width: double.infinity,
      height: _isLarge ? AppSizes.buttonHeightLarge : AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed == null ? null : (isLoading ? () {} : onPressed),
        style: ElevatedButton.styleFrom(
          // A button text style replaces the inherited one, so build it on
          // the theme style that carries the language font and tracking.
          textStyle: Theme.of(context).textTheme.labelLarge!.merge(
            _isLarge ? AppTextStyles.buttonLarge : AppTextStyles.button,
          ),
          disabledBackgroundColor: palette.accent.withValues(alpha: 0.5),
          disabledForegroundColor: palette.onAccent,
        ),
        child: isLoading
            ? SizedBox.square(
                dimension: AppSizes.loader,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: palette.onAccent,
                ),
              )
            : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
