import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// Text input bound to a reactive_forms control, styled like the design.
///
/// Error texts come from the app-wide `ReactiveFormConfig` (see `app.dart`),
/// so screens only declare validators.
class AppTextField<T> extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.large = false,
    this.validationMessages,
  });

  final String formControlName;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final TextAlign textAlign;

  /// Force left-to-right for phone numbers, card numbers, codes.
  final TextDirection? textDirection;

  final bool autofocus;

  /// The 64pt phone input of the sign in screens (18pt text).
  final bool large;

  /// Overrides of the app-wide messages for this field only.
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final style = (large ? AppTextStyles.bodyLarge : AppTextStyles.body)
        .copyWith(color: palette.textBody);
    final vertical = large
        ? AppSpacing.inputVerticalLarge
        : AppSpacing.inputVertical;

    return ReactiveTextField<T>(
      formControlName: formControlName,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      textAlign: textAlign,
      textDirection: textDirection,
      style: style,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection: textDirection,
        hintStyle: large ? style.copyWith(color: palette.hint) : null,
        prefixIcon: prefix,
        // The prefix brings its own spacing.
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: suffix,
        counterText: '',
        contentPadding: EdgeInsetsDirectional.only(
          start: prefix == null ? AppSpacing.m : 0,
          end: AppSpacing.m,
          top: vertical,
          bottom: vertical,
        ),
      ),
    );
  }
}
