import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/primary_button.dart';

/// Header + labelled fields + "Save" panel: frame of the address and card
/// forms.
class FormPage extends StatelessWidget {
  const FormPage({
    super.key,
    required this.title,
    required this.form,
    required this.fields,
    required this.onSave,
  });

  final String title;
  final FormGroup form;
  final List<Widget> fields;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Scaffold(
        body: Column(
          children: [
            GradientHeader(title: title),
            Expanded(
              child: ListView(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.m,
                  ShopDimens.formTop,
                  AppSpacing.m,
                  AppSpacing.l,
                ),
                children: [
                  for (final field in fields)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.m,
                      ),
                      child: field,
                    ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomPanel(
          child: PrimaryButton(label: context.l10n.save, onPressed: onSave),
        ),
      ),
    );
  }
}

/// Grey label above a form field ("City").
class LabelledField extends StatelessWidget {
  const LabelledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: ShopDimens.labelToField + AppSpacing.xxs,
      children: [
        Text(
          label,
          style: AppTextStyles.label.copyWith(
            color: context.palette.textSecondary,
          ),
        ),
        child,
      ],
    );
  }
}
