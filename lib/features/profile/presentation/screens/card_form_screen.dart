import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/digit_mask.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/models/payment_card.dart';
import '../providers/payment_cards_provider.dart';
import '../widgets/form_page.dart';

/// Add a card. Only the network, the last 4 digits and the expiry are kept;
/// the CVV is checked and dropped, as a real app would do.
class CardFormScreen extends ConsumerStatefulWidget {
  const CardFormScreen({super.key});

  @override
  ConsumerState<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends ConsumerState<CardFormScreen> {
  static const _number = 'number';
  static const _holder = 'holder';
  static const _expiry = 'expiry';
  static const _cvv = 'cvv';
  static const _default = 'isDefault';

  static const _numberMask = DigitMask('#### #### #### ####');
  static const _expiryMask = DigitMask('##/##');
  static const _cvvMask = DigitMask('###');

  static const _cardKey = 'card';
  static const _expiryKey = 'expiry';
  static const _cvvKey = 'cvv';

  static final _numberValidator = Validators.delegate((control) {
    final digits = DigitMask.digitsOf(control.value as String? ?? '');
    return _numberMask.isComplete(digits) && cardNetworkOf(digits) != null
        ? null
        : {_cardKey: true};
  });

  static final _expiryValidator = Validators.delegate((control) {
    final digits = DigitMask.digitsOf(control.value as String? ?? '');
    if (digits.length != 4) return {_expiryKey: true};
    final month = int.parse(digits.substring(0, 2));
    final year = 2000 + int.parse(digits.substring(2));
    final now = DateTime.now();
    final valid =
        month >= 1 &&
        month <= 12 &&
        // The card works until the end of its expiry month.
        DateTime(year, month + 1).isAfter(DateTime(now.year, now.month));
    return valid ? null : {_expiryKey: true};
  });

  static final _cvvValidator = Validators.delegate(
    (control) =>
        _cvvMask.isComplete(control.value as String?) ? null : {_cvvKey: true},
  );

  final _form = FormGroup({
    _number: FormControl<String>(validators: [_numberValidator]),
    _holder: FormControl<String>(
      validators: [Validators.required, Validators.minLength(2)],
    ),
    _expiry: FormControl<String>(validators: [_expiryValidator]),
    _cvv: FormControl<String>(validators: [_cvvValidator]),
    _default: FormControl<bool>(value: false),
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
    final number = DigitMask.digitsOf(_form.control(_number).value as String);
    final expiry = DigitMask.digitsOf(_form.control(_expiry).value as String);
    ref
        .read(paymentCardsProvider.notifier)
        .save(
          PaymentCard(
            id: generateId(),
            network: cardNetworkOf(number)!,
            holderName: (_form.control(_holder).value as String).trim(),
            last4: number.substring(number.length - 4),
            expiryMonth: int.parse(expiry.substring(0, 2)),
            expiryYear: 2000 + int.parse(expiry.substring(2)),
            isDefault: _form.control(_default).value as bool,
          ),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget digits(
      String name,
      String label,
      DigitMask mask,
      String errorKey,
      String error,
    ) => LabelledField(
      label: label,
      child: AppTextField<String>(
        formControlName: name,
        keyboardType: TextInputType.number,
        textDirection: TextDirection.ltr,
        textInputAction: TextInputAction.next,
        hintText: mask.apply('0' * mask.length),
        inputFormatters: [mask.formatter],
        validationMessages: {errorKey: (_) => error},
      ),
    );

    return FormPage(
      title: l10n.addCard,
      form: _form,
      onSave: _save,
      fields: [
        digits(
          _number,
          l10n.cardNumberLabel,
          _numberMask,
          _cardKey,
          l10n.validationCardNumber,
        ),
        LabelledField(
          label: l10n.cardHolderLabel,
          child: const AppTextField<String>(
            formControlName: _holder,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.m,
          children: [
            Expanded(
              child: digits(
                _expiry,
                l10n.expiryLabel,
                _expiryMask,
                _expiryKey,
                l10n.validationExpiry,
              ),
            ),
            Expanded(
              child: digits(
                _cvv,
                l10n.cvvLabel,
                _cvvMask,
                _cvvKey,
                l10n.validationCvv,
              ),
            ),
          ],
        ),
        ReactiveCheckboxListTile(
          formControlName: _default,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: context.palette.accent,
          title: Text(l10n.setAsDefault),
        ),
      ],
    );
  }
}
