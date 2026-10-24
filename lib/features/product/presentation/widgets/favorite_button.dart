import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';

/// Heart that adds/removes a product from favorites.
///
/// [FavoriteButton.circle] is the white round button over product images,
/// [FavoriteButton.plain] the bare heart of the product page bottom bar.
class FavoriteButton extends ConsumerWidget {
  const FavoriteButton.circle({super.key, required this.productId})
    : _circle = true;

  const FavoriteButton.plain({super.key, required this.productId})
    : _circle = false;

  final String productId;
  final bool _circle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final isFavorite = ref.watch(isFavoriteProvider(productId));
    final iconSize = _circle ? AppSizes.heartIconSmall : AppSizes.heartIcon;

    final icon = isFavorite
        ? Icon(Icons.favorite, size: iconSize, color: palette.accent)
        : GradientIcon(Icons.favorite_border, size: iconSize);

    return Semantics(
      button: true,
      toggled: isFavorite,
      label: isFavorite
          ? context.l10n.removeFromFavorites
          : context.l10n.addToFavorites,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: () => ref.read(favoritesProvider.notifier).toggle(productId),
        behavior: HitTestBehavior.opaque,
        child: _circle
            ? Container(
                width: AppSizes.heartButton,
                height: AppSizes.heartButton,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette.surface,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.soft(palette),
                ),
                child: icon,
              )
            : SizedBox.square(
                dimension: AppSizes.bottomBarSideSlot,
                child: Center(child: icon),
              ),
      ),
    );
  }
}
