import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_shadows.dart';

/// White panel with rounded top corners at the bottom of a screen ("Total
/// price + Check Out", checkout summary, product page buttons).
/// Adds the bottom safe area itself.
class BottomPanel extends StatelessWidget {
  const BottomPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.m,
      ShopDimens.panelPadding,
      AppSpacing.m,
      0,
    ),
    this.rounded = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: padding.add(
        EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: rounded
            ? const BorderRadius.vertical(top: Radius.circular(AppRadius.sheet))
            : null,
        boxShadow: AppShadows.raised(palette),
      ),
      child: child,
    );
  }
}
