import '../models/payment_card.dart';

const mastercard = PaymentCard(
  id: 'c1',
  network: CardNetwork.mastercard,
  holderName: 'Oleh Chabanov',
  last4: '5678',
  expiryMonth: 8,
  expiryYear: 2028,
  isDefault: true,
);

const visa = PaymentCard(
  id: 'c2',
  network: CardNetwork.visa,
  holderName: 'Oleh Chabanov',
  last4: '4242',
  expiryMonth: 11,
  expiryYear: 2027,
);

const mockPaymentCards = <PaymentCard>[mastercard, visa];
