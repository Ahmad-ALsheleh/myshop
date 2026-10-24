import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/profile/data/mock/mock_addresses.dart';
import 'package:myshop/features/profile/data/models/address.dart';
import 'package:myshop/features/profile/presentation/providers/addresses_provider.dart';

void main() {
  late ProviderContainer container;
  late AddressesNotifier addresses;

  List<String> defaults() => [
    for (final a in container.read(addressesProvider))
      if (a.isDefault) a.id,
  ];

  const newAddress = Address(
    id: 'new',
    fullName: 'Test User',
    street: '1 Main St',
    city: 'Austin',
    region: 'TX',
    zipCode: '73301',
    country: 'USA',
  );

  setUp(() {
    container = ProviderContainer.test();
    addresses = container.read(addressesProvider.notifier);
  });

  test('checkout uses the default address', () {
    expect(container.read(selectedAddressProvider), homeAddress);
  });

  test('setDefault keeps a single default', () {
    addresses.setDefault(workAddress.id);

    expect(defaults(), [workAddress.id]);
    expect(container.read(selectedAddressProvider)?.id, workAddress.id);
  });

  test('removing the default makes the first remaining one default', () {
    addresses.remove(homeAddress.id);

    expect(defaults(), [workAddress.id]);
  });

  test('saving a new default address clears the old default', () {
    addresses.save(newAddress.copyWithDefault(true));

    expect(container.read(addressesProvider), hasLength(3));
    expect(defaults(), ['new']);
  });

  test('saving an existing id edits it in place', () {
    addresses.save(newAddress);
    addresses.save(
      const Address(
        id: 'new',
        fullName: 'Edited',
        street: '1 Main St',
        city: 'Austin',
        region: 'TX',
        zipCode: '73301',
        country: 'USA',
      ),
    );

    expect(container.read(addressesProvider).last.fullName, 'Edited');
    expect(container.read(addressesProvider), hasLength(3));
  });

  test('removing everything leaves no selection', () {
    addresses
      ..remove(homeAddress.id)
      ..remove(workAddress.id);

    expect(container.read(selectedAddressProvider), isNull);
  });
}
