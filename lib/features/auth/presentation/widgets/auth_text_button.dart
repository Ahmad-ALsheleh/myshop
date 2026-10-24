import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Grey bold text action under the main button ("Skip", "Resend Code").
class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Text(
          label,
          style: AppTextStyles.buttonLarge.copyWith(
            color: context.palette.textSecondary,
          ),
        ),
      ),
    );
  }
}
