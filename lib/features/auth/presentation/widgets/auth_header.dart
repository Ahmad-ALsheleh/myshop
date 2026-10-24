import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/curved_header.dart';

/// Curved purple header with the big white title of the sign in screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CurvedHeader(
      height: AuthDimens.headerHeight,
      curve: AuthDimens.headerCurve,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.l,
          end: AppSpacing.l,
          top: AuthDimens.titleTop,
        ),
        child: Text(
          title,
          style: AppTextStyles.display.copyWith(
            color: context.palette.onAccent,
          ),
        ),
      ),
    );
  }
}
