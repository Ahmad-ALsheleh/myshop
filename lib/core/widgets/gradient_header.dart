import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import 'app_icon_button.dart';

/// Purple header of most screens: status bar + 44pt toolbar.
///
/// With a [bottom] widget (the search field) the gradient stops at the
/// middle of that widget, which half overlaps the header like in the design.
/// The back arrow is shown automatically when the route can pop.
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    this.title,
    this.middle,
    this.leading,
    this.trailing,
    this.bottom,
    this.bottomHeight = AppSizes.searchFieldHeight,
  });

  final String? title;

  /// Replaces [title], e.g. the "MyShop" logo on the home screen.
  final Widget? middle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? bottom;
  final double bottomHeight;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final toolbarBottom = topInset + AppSizes.toolbarHeight;
    final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;

    final toolbar = NavigationToolbar(
      leading: leading ?? (canPop ? const HeaderBackButton() : null),
      middle:
          middle ??
          (title == null
              ? null
              : Text(
                  title!,
                  style: AppTextStyles.headline.copyWith(
                    color: context.palette.onAccent,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
      trailing: trailing,
      middleSpacing: AppSpacing.m,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: toolbarBottom + (bottom == null ? 0 : bottomHeight),
        child: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              end: 0,
              top: 0,
              height: toolbarBottom + (bottom == null ? 0 : bottomHeight / 2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: context.palette.brandGradient,
                ),
              ),
            ),
            PositionedDirectional(
              start: AppSpacing.m,
              end: AppSpacing.m,
              top:
                  topInset +
                  AppSizes.toolbarContentCenter -
                  AppSizes.toolbarContentHeight / 2,
              height: AppSizes.toolbarContentHeight,
              child: toolbar,
            ),
            if (bottom != null)
              PositionedDirectional(
                start: AppSpacing.searchInset,
                end: AppSpacing.searchInset,
                top: toolbarBottom,
                height: bottomHeight,
                child: bottom!,
              ),
          ],
        ),
      ),
    );
  }
}

/// White icon of the header (menu, bell, filter...).
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
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
      size: AppSizes.headerIcon,
      color: context.palette.onAccent,
    );
  }
}

/// Back arrow; flips in Arabic.
class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderIconButton(
      icon: Icons.arrow_back,
      tooltip: context.l10n.back,
      onPressed: () => Navigator.maybePop(context),
    );
  }
}

/// White text action of the header ("Delete", "Clear").
class HeaderTextButton extends StatelessWidget {
  const HeaderTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(color: context.palette.onAccent),
      ),
    );
  }
}
