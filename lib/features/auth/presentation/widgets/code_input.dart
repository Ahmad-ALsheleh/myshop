import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Error key set on the code control when the server rejects the code.
const invalidCodeKey = 'invalidCode';

/// The 4 underlined digits of the verification screen.
///
/// One reactive_forms control holds the whole code: an invisible text field
/// on top of the boxes receives the keyboard input.
class CodeInput extends StatelessWidget {
  const CodeInput({
    super.key,
    required this.formControlName,
    required this.length,
    required this.onCompleted,
  });

  final String formControlName;
  final int length;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final control = form.control(formControlName) as FormControl<String>;
        final code = control.value ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Digits are read left to right in every language.
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AuthDimens.codeCellGap,
                    children: [
                      for (var i = 0; i < length; i++)
                        _CodeCell(digit: i < code.length ? code[i] : null),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Opacity(
                    opacity: 0,
                    child: ReactiveTextField<String>(
                      formControlName: formControlName,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: length,
                      showCursor: false,
                      enableInteractiveSelection: false,
                      showErrors: (_) => false,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        counterText: '',
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (control) {
                        if ((control.value ?? '').length == length) {
                          onCompleted();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_errorText(context, control) case final error?) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                error,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: context.palette.sale,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  String? _errorText(BuildContext context, FormControl<String> control) {
    if (!control.touched || control.valid) return null;
    return control.hasError(invalidCodeKey)
        ? context.l10n.invalidCode
        : context.l10n.validationCode;
  }
}

class _CodeCell extends StatelessWidget {
  const _CodeCell({required this.digit});

  final String? digit;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SizedBox(
      width: AuthDimens.codeCellWidth,
      child: Column(
        children: [
          Text(
            digit ?? '',
            style: AppTextStyles.codeDigit.copyWith(color: palette.textBody),
          ),
          const SizedBox(height: AuthDimens.codeDigitToLine),
          AnimatedContainer(
            duration: kThemeChangeDuration,
            height: AuthDimens.codeLine,
            color: digit == null ? palette.border : palette.success,
          ),
        ],
      ),
    );
  }
}
