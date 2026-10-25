import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/text_action_button.dart';
import '../../data/repositories/auth_repository.dart';
import '../providers/sign_in_providers.dart';
import '../widgets/auth_header.dart';

import '../widgets/code_input.dart';

/// "Verification Code": the 4 digits sent to [phone].
class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key, required this.phone});

  /// Full number: "+380991234567".
  final String phone;

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  static const _code = 'code';

  final _form = FormGroup({
    _code: FormControl<String>(
      validators: [
        Validators.required,
        Validators.pattern(RegExp('^\\d{${AuthRepository.codeLength}}\$')),
      ],
    ),
  });

  FormControl<String> get _control =>
      _form.control(_code) as FormControl<String>;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _verify() {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    ref
        .read(verifyCodeProvider.notifier)
        .verify(phone: widget.phone, code: _control.value!);
  }

  Future<void> _resend() async {
    final sent = await ref.read(sendCodeProvider.notifier).send(widget.phone);
    if (!sent || !mounted) return;
    _control.reset();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.codeResent)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final isVerifying = ref.watch(verifyCodeProvider).isLoading;

    ref.listen(verifyCodeProvider, (_, state) {
      if (state.error is InvalidCodeException) {
        _control
          ..setErrors({invalidCodeKey: true})
          ..markAsTouched();
      }
    });

    return Scaffold(
      backgroundColor: palette.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthHeader(title: l10n.verificationTitle),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.l,
              ),
              child: ReactiveForm(
                formGroup: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AuthDimens.subtitleTop),
                    Text(
                      l10n.verificationSubtitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: palette.textBody,
                      ),
                    ),
                    const SizedBox(height: AuthDimens.phoneLineGap),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          widget.phone,
                          textDirection: TextDirection.ltr,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: palette.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Text(
                            l10n.changePhoneNumber,
                            style: AppTextStyles.footnote.copyWith(
                              color: palette.textPrimary,
                              decoration: TextDecoration.underline,
                              decorationColor: palette.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AuthDimens.codeTop),
                    CodeInput(
                      formControlName: _code,
                      length: AuthRepository.codeLength,
                      onCompleted: _verify,
                    ),
                    const SizedBox(height: AuthDimens.codeToButton),
                    PrimaryButton(
                      label: l10n.sendVerificationCode,
                      size: PrimaryButtonSize.large,
                      isLoading: isVerifying,
                      onPressed: _verify,
                    ),
                    const SizedBox(height: AuthDimens.secondaryTop),
                    TextActionButton(
                      label: l10n.resendCode,
                      onPressed: _resend,
                    ),
                    const SizedBox(height: AppSpacing.l),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
