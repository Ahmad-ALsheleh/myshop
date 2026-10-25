import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';

/// Saved address or card: tap to make it the default (yellow frame +
/// "Default" badge), with edit / delete actions.
class SavedItemTile extends StatelessWidget {
  const SavedItemTile({
    super.key,
    required this.isDefault,
    required this.onSelect,
    required this.onDelete,
    required this.child,
    this.onEdit,
  });

  final bool isDefault;
  final VoidCallback onSelect;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isDefault,
      child: GestureDetector(
        onTap: onSelect,
        child: AnimatedContainer(
          duration: kThemeChangeDuration,
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(AppRadius.s),
            border: Border.all(
              width: AppSizes.selectedBorder,
              color: isDefault ? palette.accent : Colors.transparent,
            ),
            boxShadow: AppShadows.soft(palette),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    child,
                    if (isDefault)
                      Text(
                        l10n.defaultBadge,
                        style: AppTextStyles.caption.copyWith(
                          color: palette.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
              if (onEdit != null)
                AppIconButton(
                  icon: Icons.edit_outlined,
                  tooltip: l10n.edit,
                  onPressed: onEdit,
                  size: AppSizes.icon,
                  color: palette.textSecondary,
                ),
              const SizedBox(width: AppSpacing.s),
              AppIconButton(
                icon: Icons.delete_outline,
                tooltip: l10n.delete,
                onPressed: onDelete,
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
