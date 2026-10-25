import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_shadows.dart';
import '../theme/app_text_styles.dart';
import 'gradient_icon.dart';

/// White row with a gradient icon and a bold label (profile menu, settings).
class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: ProfileDimens.menuItemHeight,
          padding: const EdgeInsetsDirectional.only(
            start: ProfileDimens.menuIconStart,
            end: AppSpacing.m,
          ),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(AppRadius.s),
            boxShadow: AppShadows.soft(palette),
          ),
          child: Row(
            children: [
              GradientIcon(icon),
              const SizedBox(
                width:
                    ProfileDimens.menuTextStart -
                    ProfileDimens.menuIconStart -
                    AppSizes.icon,
              ),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.menuItem.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
