import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../data/models/product.dart';
import '../../data/models/product_color.dart';
import '../../data/models/product_size.dart';
import 'color_option_selector.dart';
import 'product_bottom_bar.dart';
import 'size_selector.dart';

/// Opens the "add to cart" sheet with the options chosen on the product page.
Future<void> showAddToCartSheet(
  BuildContext context, {
  required Product product,
  ProductColor? color,
  ProductSize? size,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _AddToCartSheet(product: product, color: color, size: size),
  );
}

class _AddToCartSheet extends ConsumerStatefulWidget {
  const _AddToCartSheet({required this.product, this.color, this.size});

  final Product product;
  final ProductColor? color;
  final ProductSize? size;

  @override
  ConsumerState<_AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends ConsumerState<_AddToCartSheet> {
  late ProductColor? _color =
      widget.color ?? widget.product.colors.firstOrNull?.color;
  late ProductSize? _size = widget.size;
  var _quantity = 1;

  bool get _canAdd => widget.product.sizes.isEmpty || _size != null;

  void _add() {
    ref
        .read(cartProvider.notifier)
        .add(widget.product, color: _color, size: _size, quantity: _quantity);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final l10n = context.l10n;
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.addedToCart),
        action: SnackBarAction(
          label: l10n.viewCart,
          onPressed: () => router.push(AppRoutes.cart),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final product = widget.product;
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.s),
        Center(
          child: Container(
            width: ShopDimens.sheetHandleWidth,
            height: ShopDimens.sheetHandleHeight,
            decoration: BoxDecoration(
              color: palette.border,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.m,
            ShopDimens.sheetTop - AppSpacing.s - ShopDimens.sheetHandleHeight,
            AppSpacing.m,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    product.imageFor(_color),
                    width: ShopDimens.sheetImage,
                    height: ShopDimens.sheetImage,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.localize(product.name),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body.copyWith(
                            color: palette.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          formatPrice(product.price * _quantity),
                          style: AppTextStyles.priceLarge.copyWith(
                            color: palette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QuantityStepper(
                    value: _quantity,
                    onIncrement: () => setState(() => _quantity++),
                    onDecrement: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                  ),
                ],
              ),
              if (product.colors.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.m),
                Text(l10n.colorsLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.xs),
                ColorOptionSelector(
                  options: product.colors,
                  selected: _color,
                  onTap: (color) => setState(() => _color = color),
                ),
              ],
              if (product.sizes.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.s),
                Text(l10n.sizesLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.xs),
                SizeSelector(
                  sizes: product.sizes,
                  selected: {?_size},
                  onTap: (size) => setState(() => _size = size),
                ),
              ],
              const SizedBox(height: AppSpacing.l),
            ],
          ),
        ),
        ProductBottomBar(
          productId: product.id,
          onBack: () => Navigator.pop(context),
          onAddToCart: _canAdd ? _add : null,
        ),
      ],
    );
  }
}
