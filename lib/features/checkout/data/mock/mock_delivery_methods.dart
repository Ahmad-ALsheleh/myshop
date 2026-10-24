import '../models/delivery_method.dart';

const _logos = 'assets/images/delivery';

const dhl = DeliveryMethod(
  id: 'dhl',
  name: 'DHL',
  logo: '$_logos/dhl.png',
  price: 1500,
  minDays: 1,
  maxDays: 2,
);

const fedEx = DeliveryMethod(
  id: 'fedex',
  name: 'FedEx',
  logo: '$_logos/fedex.png',
  price: 1800,
  minDays: 1,
  maxDays: 2,
);

const usps = DeliveryMethod(
  id: 'usps',
  name: 'USPS',
  logo: '$_logos/usps.png',
  price: 2000,
  minDays: 1,
  maxDays: 2,
);

const mockDeliveryMethods = <DeliveryMethod>[dhl, fedEx, usps];

/// Selected in the design.
const mockDefaultDeliveryMethod = fedEx;
