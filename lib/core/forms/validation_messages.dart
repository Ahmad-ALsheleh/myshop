import 'package:reactive_forms/reactive_forms.dart';

import '../../l10n/generated/app_localizations.dart';
import '../utils/digit_mask.dart';

/// Error key of [phoneValidator].
const phoneValidationKey = 'phone';

/// Valid when the number has all the digits of [mask].
Validator<dynamic> phoneValidator(DigitMask mask) => Validators.delegate(
  (control) => mask.isComplete(control.value as String?)
      ? null
      : {phoneValidationKey: true},
);

/// Translated error texts of the reactive_forms validators, registered once
/// for the whole app with `ReactiveFormConfig`.
Map<String, ValidationMessageFunction> appValidationMessages(
  AppLocalizations l10n,
) {
  int length(Object error) =>
      (error as Map<String, dynamic>)['requiredLength'] as int;

  return {
    ValidationMessage.required: (_) => l10n.validationRequired,
    ValidationMessage.minLength: (error) =>
        l10n.validationMinLength(length(error)),
    ValidationMessage.maxLength: (error) =>
        l10n.validationMaxLength(length(error)),
    ValidationMessage.number: (_) => l10n.validationNumber,
    ValidationMessage.email: (_) => l10n.validationEmail,
    ValidationMessage.pattern: (_) => l10n.validationPattern,
    phoneValidationKey: (_) => l10n.validationPhone,
  };
}
