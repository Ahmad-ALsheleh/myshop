import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../cart/presentation/widgets/cart_pill.dart';

/// White tab bar of the 4 main tabs, with the cart pill on its end edge.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onCartTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onCartTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final tabs = [
      (Icons.home_outlined, Icons.home_rounded, l10n.navHome),
      (Icons.grid_view_outlined, Icons.grid_view_rounded, l10n.navCatalogue),
      (Icons.favorite_border, Icons.favorite, l10n.navFavorite),
      (Icons.person_outline, Icons.person, l10n.navProfile),
    ];

    // The pill sticks out above the bar: that strip is part of this widget
    // (transparent) so the whole pill stays tappable. Use it with
    // `Scaffold.extendBody` so the content shows through the strip.
    return SizedBox(
      height: AppSizes.cartPillRise + AppSizes.navBarHeight + bottomInset,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: Container(
              height: AppSizes.navBarHeight + bottomInset,
              padding: EdgeInsetsDirectional.only(
                start: AppSpacing.m,
                // The tabs stay in the space next to the cart pill.
                end: AppSizes.cartPillWidth,
                top: AppSpacing.navBarTop,
                bottom: bottomInset,
              ),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(AppRadius.sheet),
                ),
                boxShadow: AppShadows.raised(palette),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSizes.navItemGap,
                children: [
                  for (final (index, (icon, activeIcon, label)) in tabs.indexed)
                    Flexible(
                      child: _NavItem(
                        icon: icon,
                        activeIcon: activeIcon,
                        label: label,
                        isActive: index == currentIndex,
                        onTap: () => onTabSelected(index),
                      ),
                    ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: 0,
            child: CartPill(onTap: onCartTap),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isActive,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.navLabelGap,
          children: [
            if (isActive)
              GradientIcon(activeIcon)
            else
              Icon(icon, size: AppSizes.icon, color: palette.textSecondary),
            // Long labels (narrow screens, big text) shrink instead of
            // overflowing.
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: AppTextStyles.caption.copyWith(
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: isActive ? palette.textPrimary : palette.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
