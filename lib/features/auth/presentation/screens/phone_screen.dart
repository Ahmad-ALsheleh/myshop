import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/forms/validation_messages.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/models/country.dart';
import '../providers/session_provider.dart';
import '../providers/sign_in_providers.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/country_picker_sheet.dart';
import '../widgets/phone_prefix.dart';

/// "What Is Your Phone Number?"
class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  static const _phone = 'phone';

  late final _form = FormGroup({
    _phone: FormControl<String>(
      validators: _validatorsFor(ref.read(selectedCountryProvider)),
    ),
  });

  FormControl<String> get _control =>
      _form.control(_phone) as FormControl<String>;

  List<Validator<dynamic>> _validatorsFor(Country country) => [
    Validators.required,
    phoneValidator(country.mask),
  ];

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _pickCountry(Country selected) async {
    final country = await showCountryPicker(
      context,
      countries: ref.read(countriesProvider),
      selected: selected,
    );
    if (country != null) {
      ref.read(selectedCountryProvider.notifier).select(country);
    }
  }

  Future<void> _sendCode(Country country) async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    final phone = country.fullNumber(_control.value!);
    final sent = await ref.read(sendCodeProvider.notifier).send(phone);
    if (sent && mounted) context.push(AppRoutes.verificationOf(phone));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final country = ref.watch(selectedCountryProvider);
    final isSending = ref.watch(sendCodeProvider).isLoading;

    // A new country means a new number layout.
    ref.listen(selectedCountryProvider, (_, country) {
      _control
        ..setValidators(_validatorsFor(country))
        ..value = country.mask.apply(_control.value ?? '');
    });

    return Scaffold(
      backgroundColor: palette.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthHeader(title: l10n.phoneTitle),
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
                      l10n.phoneSubtitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: palette.textBody,
                      ),
                    ),
                    const SizedBox(height: AuthDimens.fieldTop),
                    // Phone numbers read left to right, also in Arabic.
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: AppTextField<String>(
                        formControlName: _phone,
                        large: true,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        hintText: country.mask.apply('9' * country.mask.length),
                        inputFormatters: [country.mask.formatter],
                        prefix: PhonePrefix(
                          country: country,
                          onTap: () => _pickCountry(country),
                        ),
                      ),
                    ),
                    const SizedBox(height: AuthDimens.buttonTop),
                    PrimaryButton(
                      label: l10n.sendVerificationCode,
                      size: PrimaryButtonSize.large,
                      isLoading: isSending,
                      onPressed: () => _sendCode(country),
                    ),
                    const SizedBox(height: AuthDimens.secondaryTop),
                    AuthTextButton(
                      label: l10n.skip,
                      onPressed: () =>
                          ref.read(guestModeProvider.notifier).set(true),
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
