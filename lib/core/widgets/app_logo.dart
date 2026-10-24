import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_text_styles.dart';

/// "MyShop" wordmark: "My" in yellow, "Shop" in white. Always Latin and
/// left-to-right, also in Arabic.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.fontSize});

  /// Defaults to the header size; the onboarding screen uses a bigger one.
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final style = AppTextStyles.logo.copyWith(fontSize: fontSize);
    return Semantics(
      label: context.l10n.appName,
      excludeSemantics: true,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'My',
              style: style.copyWith(color: palette.accent),
            ),
            TextSpan(
              text: 'Shop',
              style: style.copyWith(color: palette.onAccent),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
