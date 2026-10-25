import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../checkout/presentation/widgets/checkout_parts.dart';
import '../providers/payment_cards_provider.dart';
import '../widgets/card_network_logo.dart';
import '../widgets/saved_item_tile.dart';

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final cards = ref.watch(paymentCardsProvider);
    final notifier = ref.read(paymentCardsProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(title: l10n.paymentMethods),
          Expanded(
            child: cards.isEmpty
                ? EmptyState(
                    icon: Icons.credit_card_outlined,
                    message: l10n.noCards,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    itemCount: cards.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.m),
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      final expiry =
                          '${card.expiryMonth.toString().padLeft(2, '0')}/'
                          '${card.expiryYear % 100}';
                      return SavedItemTile(
                        isDefault: card.isDefault,
                        onSelect: () => notifier.setDefault(card.id),
                        onDelete: () async {
                          final confirmed = await showConfirmDialog(
                            context,
                            message: l10n.deleteCardConfirm,
                            confirmLabel: l10n.delete,
                          );
                          if (confirmed) notifier.remove(card.id);
                        },
                        child: Row(
                          spacing: AppSpacing.s,
                          children: [
                            CardNetworkLogo(network: card.network),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaskedCardNumber(last4: card.last4),
                                  Text(
                                    '${card.holderName} · ${l10n.expires(expiry)}',
                                    style: AppTextStyles.footnote.copyWith(
                                      color: palette.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPanel(
        child: PrimaryButton(
          label: l10n.addCard,
          onPressed: () => context.push(AppRoutes.cardForm),
        ),
      ),
    );
  }
}
