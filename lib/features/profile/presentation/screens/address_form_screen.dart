import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/models/address.dart';
import '../providers/addresses_provider.dart';
import '../widgets/form_page.dart';

/// Add a new address, or edit the one with [addressId].
class AddressFormScreen extends ConsumerStatefulWidget {
  const AddressFormScreen({super.key, this.addressId});

  final String? addressId;

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  static const _name = 'fullName';
  static const _street = 'street';
  static const _city = 'city';
  static const _region = 'region';
  static const _zip = 'zipCode';
  static const _country = 'country';
  static const _default = 'isDefault';

  late final Address? _editing = ref
      .read(addressesProvider)
      .where((address) => address.id == widget.addressId)
      .firstOrNull;

  late final _form = FormGroup({
    _name: FormControl<String>(
      value: _editing?.fullName,
      validators: [Validators.required, Validators.minLength(2)],
    ),
    _street: FormControl<String>(
      value: _editing?.street,
      validators: [Validators.required],
    ),
    _city: FormControl<String>(
      value: _editing?.city,
      validators: [Validators.required],
    ),
    _region: FormControl<String>(
      value: _editing?.region,
      validators: [Validators.required],
    ),
    _zip: FormControl<String>(
      value: _editing?.zipCode,
      validators: [Validators.required, Validators.pattern(r'^\d{4,10}$')],
    ),
    _country: FormControl<String>(
      value: _editing?.country,
      validators: [Validators.required],
    ),
    _default: FormControl<bool>(value: _editing?.isDefault ?? false),
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
    String text(String name) => (_form.control(name).value as String).trim();
    ref
        .read(addressesProvider.notifier)
        .save(
          Address(
            id: _editing?.id ?? generateId(),
            fullName: text(_name),
            street: text(_street),
            city: text(_city),
            region: text(_region),
            zipCode: text(_zip),
            country: text(_country),
            isDefault: _form.control(_default).value as bool,
          ),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget field(String name, String label, {TextInputType? keyboard}) =>
        LabelledField(
          label: label,
          child: AppTextField<String>(
            formControlName: name,
            keyboardType: keyboard,
            textInputAction: TextInputAction.next,
          ),
        );

    return FormPage(
      title: _editing == null ? l10n.addAddress : l10n.editAddress,
      form: _form,
      onSave: _save,
      fields: [
        field(_name, l10n.fullNameLabel, keyboard: TextInputType.name),
        field(_street, l10n.streetLabel, keyboard: TextInputType.streetAddress),
        field(_city, l10n.cityLabel),
        field(_region, l10n.regionLabel),
        field(_zip, l10n.zipCodeLabel, keyboard: TextInputType.number),
        field(_country, l10n.countryLabel),
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
