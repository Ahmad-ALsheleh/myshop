import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_text_styles.dart';

/// Grey bold text action under a main button ("Skip", "Go to Orders").
class TextActionButton extends StatelessWidget {
  const TextActionButton({
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
