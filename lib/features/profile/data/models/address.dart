import 'package:flutter/foundation.dart';

import 'defaultable.dart';

/// A shipping address. Shown as-is in both languages (it is user data).
@immutable
class Address implements Defaultable<Address> {
  const Address({
    required this.id,
    required this.fullName,
    required this.street,
    required this.city,
    required this.region,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
  });

  @override
  final String id;
  final String fullName;
  final String street;
  final String city;

  /// State / province, e.g. "IL".
  final String region;
  final String zipCode;
  final String country;

  @override
  final bool isDefault;

  /// Second line of the address card: "Springfield, IL 62704, USA".
  String get cityLine => '$city, $region $zipCode, $country';

  @override
  Address copyWithDefault(bool isDefault) => Address(
    id: id,
    fullName: fullName,
    street: street,
    city: city,
    region: region,
    zipCode: zipCode,
    country: country,
    isDefault: isDefault,
  );
}
