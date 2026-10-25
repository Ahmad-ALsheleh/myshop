import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/providers/session_provider.dart';

/// Edit profile (✎): the name, in a small reactive form.
Future<void> showEditProfileSheet(BuildContext context, String currentName) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _EditProfileSheet(currentName: currentName),
  );
}

class _EditProfileSheet extends ConsumerStatefulWidget {
  const _EditProfileSheet({required this.currentName});

  final String currentName;

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  static const _name = 'name';

  late final _form = FormGroup({
    _name: FormControl<String>(
      value: widget.currentName,
      validators: [Validators.required, Validators.minLength(2)],
    ),
  });

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _save() {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    ref
        .read(sessionProvider.notifier)
        .updateName((_form.control(_name).value as String).trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.m,
        0,
        AppSpacing.m,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.m,
      ),
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.m,
          children: [
            Text(
              l10n.editProfile,
              style: AppTextStyles.headline.copyWith(
                color: context.palette.textPrimary,
              ),
            ),
            AppTextField<String>(
              formControlName: _name,
              hintText: l10n.nameLabel,
              keyboardType: TextInputType.name,
              autofocus: true,
            ),
            PrimaryButton(label: l10n.save, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
