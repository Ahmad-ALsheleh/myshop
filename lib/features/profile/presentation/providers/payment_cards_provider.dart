import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/defaultable.dart';
import '../../data/models/payment_card.dart';
import '../../data/repositories/payment_card_repository.dart';
import 'defaultable_list_notifier.dart';

final paymentCardsProvider =
    NotifierProvider<PaymentCardsNotifier, List<PaymentCard>>(
      PaymentCardsNotifier.new,
    );

class PaymentCardsNotifier extends DefaultableListNotifier<PaymentCard> {
  @override
  List<PaymentCard> build() =>
      ref.watch(paymentCardRepositoryProvider).loadCards();
}

/// The card used at checkout. `null` when none is saved.
final selectedPaymentCardProvider = Provider<PaymentCard?>(
  (ref) => ref.watch(paymentCardsProvider).defaultItem,
);
