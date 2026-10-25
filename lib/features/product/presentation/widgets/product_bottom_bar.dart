import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/primary_button.dart';
import 'favorite_button.dart';

/// "←  [Add to Cart]  ♡" bar of the product page and the add to cart sheet.
class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.productId,
    required this.onBack,
    required this.onAddToCart,
  });

  final String productId;
  final VoidCallback onBack;

  /// `null` disables the button (e.g. no size chosen yet).
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return BottomPanel(
      padding: const EdgeInsetsDirectional.only(top: ShopDimens.bottomBarTop),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.bottomBarSideSlot,
            // heightFactor: a plain Center would fill the whole screen here.
            child: Center(
              heightFactor: 1,
              child: AppIconButton(
                icon: Icons.arrow_back,
                tooltip: context.l10n.back,
                onPressed: onBack,
                size: AppSizes.headerIcon,
                color: palette.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: PrimaryButton(
              label: context.l10n.addToCart,
              onPressed: onAddToCart,
            ),
          ),
          FavoriteButton.plain(productId: productId),
        ],
      ),
    );
  }
}
