import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// Read-only 48pt field showing the current choice with a chevron
/// ("Dresses  >"); tapping it opens a picker.
class SelectField extends StatelessWidget {
  const SelectField({super.key, required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSizes.inputHeight,
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.m,
            end: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(AppRadius.s),
            border: Border.all(color: palette.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(color: palette.textBody),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: AppSizes.icon,
                color: palette.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
