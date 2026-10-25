import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../../core/widgets/total_row.dart';
import '../../data/models/cart_item.dart';
import '../providers/cart_provider.dart';

/// Cart lines (swipe to remove one, "Delete" empties the cart) and the
/// total / Check Out panel.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.clearCartConfirm,
      confirmLabel: l10n.delete,
    );
    if (confirmed) ref.read(cartProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final items = ref.watch(cartProvider);
    final cart = ref.read(cartProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: l10n.cart,
            trailing: items.isEmpty
                ? null
                : HeaderTextButton(
                    label: l10n.delete,
                    onPressed: () => _confirmClear(context, ref),
                  ),
          ),
          Expanded(
            child: items.isEmpty
                ? EmptyState(
                    icon: Icons.shopping_cart_outlined,
                    message: l10n.emptyCart,
                  )
                : SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(AppRadius.s),
                        ),
                        boxShadow: AppShadows.soft(palette),
                      ),
                      child: Column(
                        children: [
                          for (final (index, item) in items.indexed) ...[
                            if (index > 0) const Divider(),
                            Dismissible(
                              key: ValueKey(
                                '${item.product.id}-${item.color}-${item.size}',
                              ),
                              direction: DismissDirection.endToStart,
                              background: _RemoveBackground(),
                              onDismissed: (_) => cart.remove(item),
                              child: _CartLine(
                                item: item,
                                onIncrement: () => cart.increment(item),
                                onDecrement: item.quantity > 1
                                    ? () => cart.decrement(item)
                                    : null,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: items.isEmpty
          ? null
          : BottomPanel(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TotalRow(label: l10n.totalPrice, amount: items.totalPrice),
                  const SizedBox(height: ShopDimens.panelPadding),
                  PrimaryButton(
                    label: l10n.checkOut,
                    onPressed: () => context.push(AppRoutes.checkout),
                  ),
                ],
              ),
            ),
    );
  }
}

/// Red background revealed when a line is swiped away.
class _RemoveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return ColoredBox(
      color: palette.sale,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: AppSpacing.l),
          child: Icon(Icons.delete_outline, color: palette.onAccent),
        ),
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  const _CartLine({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.all(ShopDimens.cartRowPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.image,
            width: ShopDimens.cartImage,
            height: ShopDimens.cartImage,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localize(item.product.name),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatPrice(item.totalPrice),
                  style: AppTextStyles.price.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          QuantityStepper(
            value: item.quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}
