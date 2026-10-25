import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import 'gradient_icon.dart';

/// Centered icon + message for empty lists (no results, empty cart...).
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.m,
        children: [
          GradientIcon(icon, size: AppSizes.emptyStateIcon),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
