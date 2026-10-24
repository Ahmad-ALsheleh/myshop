import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_delivery_methods.dart';
import '../models/delivery_method.dart';

final deliveryRepositoryProvider = Provider<DeliveryRepository>(
  (ref) => DeliveryRepository(),
);

class DeliveryRepository {
  List<DeliveryMethod> getAll() => mockDeliveryMethods;

  DeliveryMethod getDefault() => mockDefaultDeliveryMethod;
}
