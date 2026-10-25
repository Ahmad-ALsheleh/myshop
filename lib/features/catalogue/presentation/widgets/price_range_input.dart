import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Price slider + the "$0 | $5000" box below it. Both edit the same two
/// form controls (whole dollars).
class PriceRangeInput extends StatelessWidget {
  const PriceRangeInput({
    super.key,
    required this.minControlName,
    required this.maxControlName,
    required this.limit,
  });

  final String minControlName;
  final String maxControlName;

  /// Highest selectable price, in dollars.
  final int limit;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final min = form.control(minControlName).value as int? ?? 0;
        final max = form.control(maxControlName).value as int? ?? limit;
        return Column(
          children: [
            SliderTheme(
              data: SliderThemeData(
                padding: const EdgeInsets.symmetric(
                  horizontal: ShopDimens.sliderThumb / 2,
                ),
                trackHeight: AppSizes.selectedBorder * 2,
                activeTrackColor: palette.accent,
                inactiveTrackColor: palette.border,
                thumbColor: palette.surface,
                overlayShape: SliderComponentShape.noOverlay,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: ShopDimens.sliderThumb / 2,
                  elevation: 2,
                ),
                rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
              ),
              child: RangeSlider(
                min: 0,
                max: limit.toDouble(),
                values: RangeValues(
                  min.clamp(0, limit).toDouble(),
                  max.clamp(0, limit).toDouble(),
                ),
                onChanged: (values) => form.patchValue({
                  minControlName: values.start.round(),
                  maxControlName: values.end.round(),
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            Container(
              height: AppSizes.inputHeight,
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(AppRadius.s),
                border: Border.all(color: palette.border),
              ),
              // Prices read left to right in Arabic too.
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    Expanded(child: _PriceField(controlName: minControlName)),
                    VerticalDivider(width: 1, color: palette.border),
                    Expanded(child: _PriceField(controlName: maxControlName)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({required this.controlName});

  final String controlName;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body.copyWith(color: context.palette.textBody);
    return ReactiveTextField<int>(
      formControlName: controlName,
      valueAccessor: _DollarValueAccessor(),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: style,
      showErrors: (_) => false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d$]'))],
      decoration: const InputDecoration(
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}

/// Shows the dollar amount as "$123" and reads the digits back.
class _DollarValueAccessor extends ControlValueAccessor<int, String> {
  @override
  String? modelToViewValue(int? modelValue) =>
      modelValue == null ? '' : '\$$modelValue';

  @override
  int? viewToModelValue(String? viewValue) =>
      int.tryParse((viewValue ?? '').replaceAll(RegExp(r'\D'), ''));
}
