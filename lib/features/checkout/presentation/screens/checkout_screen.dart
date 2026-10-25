import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/options_sheet.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/total_row.dart';
import '../../../profile/presentation/providers/addresses_provider.dart';
import '../../../profile/presentation/providers/payment_cards_provider.dart';
import '../providers/checkout_provider.dart';
import '../widgets/checkout_parts.dart';
import '../widgets/success_dialog.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  Future<void> _pay(BuildContext context, WidgetRef ref) async {
    final order = await ref.read(checkoutProvider.notifier).placeOrder();
    if (order == null || !context.mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => SuccessDialog(
        onContinueShopping: () => context.go(AppRoutes.home),
        onGoToOrders: () {
          context.go(AppRoutes.home);
          context.push(AppRoutes.orders);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final checkout = ref.watch(checkoutProvider);
    final summary = ref.watch(orderSummaryProvider);
    final address = ref.watch(selectedAddressProvider);
    final card = ref.watch(selectedPaymentCardProvider);
    final hintStyle = AppTextStyles.body.copyWith(color: palette.textSecondary);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(title: l10n.checkOut),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.m,
                ShopDimens.formTop,
                AppSpacing.m,
                AppSpacing.l,
              ),
              children: [
                CheckoutSection(
                  icon: Icons.location_on_outlined,
                  title: l10n.shippingAddress,
                  child: address == null
                      ? Text(l10n.noAddress, style: hintStyle)
                      : AddressCard(
                          address: address,
                          onChange: () async {
                            final chosen = await showOptionsSheet(
                              context,
                              title: l10n.shippingAddress,
                              options: ref.read(addressesProvider),
                              selected: address,
                              labelOf: (a) => '${a.street}, ${a.cityLine}',
                            );
                            if (chosen != null) {
                              ref
                                  .read(addressesProvider.notifier)
                                  .setDefault(chosen.id);
                            }
                          },
                        ),
                ),
                const SizedBox(height: ShopDimens.sectionGapCheckout),
                CheckoutSection(
                  icon: Icons.local_shipping_outlined,
                  title: l10n.deliveryMethod,
                  child: Row(
                    spacing: AppSpacing.m,
                    children: [
                      for (final method in ref.watch(deliveryMethodsProvider))
                        Expanded(
                          child: DeliveryMethodCard(
                            method: method,
                            isSelected: method.id == checkout.deliveryMethod.id,
                            onTap: () => ref
                                .read(checkoutProvider.notifier)
                                .selectDeliveryMethod(method),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: ShopDimens.sectionGapCheckout),
                CheckoutSection(
                  icon: Icons.credit_card_outlined,
                  title: l10n.paymentMethod,
                  child: card == null
                      ? Text(l10n.noCard, style: hintStyle)
                      : PaymentCardTile(
                          card: card,
                          onChange: () async {
                            final chosen = await showOptionsSheet(
                              context,
                              title: l10n.paymentMethod,
                              options: ref.read(paymentCardsProvider),
                              selected: card,
                              labelOf: (c) =>
                                  '${c.network.name.toUpperCase()} •••• ${c.last4}',
                            );
                            if (chosen != null) {
                              ref
                                  .read(paymentCardsProvider.notifier)
                                  .setDefault(chosen.id);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SummaryRow(label: l10n.itemsLabel, amount: summary.itemsTotal),
            const SizedBox(height: ShopDimens.summaryRowGap),
            SummaryRow(label: l10n.deliveryLabel, amount: summary.deliveryFee),
            const SizedBox(height: AppSpacing.m),
            TotalRow(label: l10n.totalPrice, amount: summary.total),
            const SizedBox(height: ShopDimens.panelPadding),
            PrimaryButton(
              label: l10n.pay,
              isLoading: checkout.isPlacingOrder,
              onPressed: address != null && card != null
                  ? () => _pay(context, ref)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
