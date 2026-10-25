import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../cart/data/models/cart_item.dart';
import '../../data/models/order.dart';
import '../providers/orders_provider.dart';

/// Order history (not in the design: same style as the other lists).
class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(title: context.l10n.orders),
          Expanded(
            child: orders.isEmpty
                ? EmptyState(
                    icon: Icons.assignment_outlined,
                    message: context.l10n.noOrders,
                  )
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.m,
                      ShopDimens.formTop,
                      AppSpacing.m,
                      MediaQuery.paddingOf(context).bottom + AppSpacing.m,
                    ),
                    itemCount: orders.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.m),
                    itemBuilder: (context, index) =>
                        _OrderCard(order: orders[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  static const _maxThumbnails = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(AppRadius.s),
        boxShadow: AppShadows.soft(palette),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.orderNumber(order.number),
                  style: AppTextStyles.title.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
              ),
              _StatusChip(status: order.status),
            ],
          ),
          Text(
            DateFormat.yMMMd(locale).format(order.createdAt),
            style: AppTextStyles.footnote.copyWith(
              color: palette.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Row(
            children: [
              for (final item in order.items.take(_maxThumbnails))
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    child: Image.asset(
                      item.image,
                      width: AppSizes.heartButton,
                      height: AppSizes.heartButton,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.itemsCount(order.items.totalQuantity),
                    style: AppTextStyles.footnote.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                  Text(
                    formatPrice(order.summary.total),
                    style: AppTextStyles.price.copyWith(
                      color: palette.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final (label, color) = switch (status) {
      OrderStatus.processing => (l10n.orderProcessing, palette.accent),
      OrderStatus.shipped => (l10n.orderShipped, palette.link),
      OrderStatus.delivered => (l10n.orderDelivered, palette.success),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
