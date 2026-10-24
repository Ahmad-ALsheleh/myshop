import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_addresses.dart';
import '../models/address.dart';

final addressRepositoryProvider = Provider<AddressRepository>(
  (ref) => AddressRepository(),
);

class AddressRepository {
  /// The saved addresses the app starts with.
  List<Address> loadAddresses() => mockAddresses;
}
