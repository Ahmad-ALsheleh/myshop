import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../data/models/cart_item.dart';
import '../providers/cart_provider.dart';

/// Purple "🛒 $239.98 / 2 items" tab glued to the end edge of the bottom
/// navigation.
class CartPill extends ConsumerWidget {
  const CartPill({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final items = ref.watch(cartProvider);
    final textStyle = AppTextStyles.caption.copyWith(color: palette.onAccent);

    return Semantics(
      button: true,
      label: context.l10n.openCart,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppSizes.cartPillWidth,
          height: AppSizes.cartPillHeight,
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.cartPillStart,
          ),
          decoration: BoxDecoration(
            gradient: palette.brandGradient,
            borderRadius: const BorderRadiusDirectional.horizontal(
              start: Radius.circular(AppSizes.cartPillHeight / 2),
            ),
          ),
          child: Row(
            spacing: AppSpacing.cartPillIconGap,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: AppSizes.cartPillIcon,
                color: palette.onAccent,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatPrice(items.totalPrice),
                      style: textStyle.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                    ),
                    Text(
                      context.l10n.itemsCount(items.totalQuantity),
                      style: textStyle.copyWith(
                        color: palette.onAccent.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
