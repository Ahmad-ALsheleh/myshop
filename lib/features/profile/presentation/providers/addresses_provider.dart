import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/address.dart';
import '../../data/models/defaultable.dart';
import '../../data/repositories/address_repository.dart';
import 'defaultable_list_notifier.dart';

final addressesProvider = NotifierProvider<AddressesNotifier, List<Address>>(
  AddressesNotifier.new,
);

class AddressesNotifier extends DefaultableListNotifier<Address> {
  @override
  List<Address> build() => ref.watch(addressRepositoryProvider).loadAddresses();
}

/// The shipping address used at checkout. `null` when none is saved.
final selectedAddressProvider = Provider<Address?>(
  (ref) => ref.watch(addressesProvider).defaultItem,
);
