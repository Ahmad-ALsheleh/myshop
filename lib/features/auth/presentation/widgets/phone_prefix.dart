import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/country.dart';

/// "🇺🇦 ⌄ +380" at the start of the phone input; tapping it opens the
/// country picker.
class PhonePrefix extends StatelessWidget {
  const PhonePrefix({super.key, required this.country, required this.onTap});

  final Country country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      label: context.l10n.selectCountry,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.m,
            end: AuthDimens.dialCodeGap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: AuthDimens.flagWidth,
                height: AuthDimens.flagHeight,
                child: FittedBox(
                  child: Text(country.flag, textDirection: TextDirection.ltr),
                ),
              ),
              const SizedBox(width: AuthDimens.prefixGap),
              Icon(
                Icons.keyboard_arrow_down,
                size: AuthDimens.chevron,
                color: palette.textBody,
              ),
              const SizedBox(width: AuthDimens.prefixGap),
              Text(
                country.dialCode,
                textDirection: TextDirection.ltr,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: palette.textBody,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
