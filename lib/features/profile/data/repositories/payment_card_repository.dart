import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_payment_cards.dart';
import '../models/payment_card.dart';

final paymentCardRepositoryProvider = Provider<PaymentCardRepository>(
  (ref) => PaymentCardRepository(),
);

class PaymentCardRepository {
  /// The saved cards the app starts with.
  List<PaymentCard> loadCards() => mockPaymentCards;
}
