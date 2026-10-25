import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/models/product.dart';
import '../../data/models/product_color.dart';
import '../../data/models/product_size.dart';
import '../providers/product_providers.dart';
import '../widgets/add_to_cart_sheet.dart';
import '../widgets/color_option_selector.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/product_price.dart';
import '../widgets/rating_stars.dart';
import '../widgets/review_tile.dart';
import '../widgets/size_selector.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  ProductColor? _color;
  ProductSize? _size;

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider(widget.productId));
    if (product == null) return const Scaffold();
    final color = _color ?? product.colors.firstOrNull?.color;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // The photo has a white background.
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Block(
                isFirst: true,
                child: _MainInfo(
                  product: product,
                  color: color,
                  size: _size,
                  onColor: (value) => setState(() => _color = value),
                  onSize: (value) => setState(() => _size = value),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Block(child: _Description(product: product)),
            ),
            SliverToBoxAdapter(
              child: _Block(child: _Reviews(productId: product.id)),
            ),
            SliverToBoxAdapter(child: _Related(productId: product.id)),
          ],
        ),
        bottomNavigationBar: ProductBottomBar(
          productId: product.id,
          onBack: () => context.pop(),
          onAddToCart: () => showAddToCartSheet(
            context,
            product: product,
            color: color,
            size: _size,
          ),
        ),
      ),
    );
  }
}

/// White rounded block; the grey background shows between blocks.
class _Block extends StatelessWidget {
  const _Block({required this.child, this.isFirst = false});

  final Widget child;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(AppRadius.s);
    return Container(
      margin: EdgeInsets.only(top: isFirst ? 0 : ShopDimens.blockGap),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: isFirst
            ? const BorderRadius.vertical(bottom: radius)
            : const BorderRadius.all(radius),
      ),
      child: child,
    );
  }
}

class _MainInfo extends ConsumerWidget {
  const _MainInfo({
    required this.product,
    required this.color,
    required this.size,
    required this.onColor,
    required this.onSize,
  });

  final Product product;
  final ProductColor? color;
  final ProductSize? size;
  final ValueChanged<ProductColor> onColor;
  final ValueChanged<ProductSize> onSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final reviews = ref.watch(productReviewsProvider(product.id));
    final labelStyle = AppTextStyles.label.copyWith(
      color: palette.textSecondary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Gallery(images: product.images),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.m,
            ShopDimens.ratingTop,
            AppSpacing.m,
            ShopDimens.blockPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  RatingStars(
                    rating: product.rating,
                    size: ShopDimens.productStar,
                    spacing: 0,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.reviewsCount(reviews.length),
                    style: AppTextStyles.footnote.copyWith(
                      color: palette.textBody,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product.inStock ? l10n.inStock : l10n.outOfStock,
                    style: AppTextStyles.footnote.copyWith(
                      fontWeight: FontWeight.w700,
                      color: product.inStock ? palette.success : palette.sale,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s),
              Text(
                context.localize(product.name),
                style: AppTextStyles.productTitle.copyWith(
                  color: palette.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.s),
              ProductPrice(product: product, style: AppTextStyles.priceHero),
              if (product.colors.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.m),
                Text(l10n.colorsLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.xs),
                ColorOptionSelector(
                  options: product.colors,
                  selected: color,
                  onTap: onColor,
                ),
              ],
              if (product.sizes.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.s),
                Text(l10n.sizesLabel, style: labelStyle),
                const SizedBox(height: AppSpacing.xs),
                SizeSelector(
                  sizes: product.sizes,
                  selected: {?size},
                  onTap: onSize,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Square photo carousel with dots when there are several photos.
class _Gallery extends StatefulWidget {
  const _Gallery({required this.images});

  final List<String> images;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  var _page = 0;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) => ColoredBox(
              color: palette.onAccent,
              child: Image.asset(widget.images[index], fit: BoxFit.cover),
            ),
          ),
          if (widget.images.length > 1)
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: AppSpacing.s,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.xxs,
                children: [
                  for (var i = 0; i < widget.images.length; i++)
                    Container(
                      width: ShopDimens.galleryDot,
                      height: ShopDimens.galleryDot,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _page ? palette.onAccent : palette.border,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// "Product details": 4 lines, the chevron shows the rest.
class _Description extends StatefulWidget {
  const _Description({required this.product});

  final Product product;

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.m,
        ShopDimens.blockPadding,
        AppSpacing.m,
        AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: l10n.productDetails),
          const SizedBox(height: AppSpacing.xxs),
          AnimatedSize(
            duration: kThemeAnimationDuration,
            alignment: AlignmentDirectional.topStart,
            child: Text(
              context.localize(widget.product.description),
              maxLines: _expanded ? null : ShopDimens.descriptionLines.toInt(),
              overflow: _expanded ? null : TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(color: palette.textBody),
            ),
          ),
          IconButton(
            tooltip: _expanded ? l10n.showLess : l10n.showMore,
            onPressed: () => setState(() => _expanded = !_expanded),
            icon: Icon(
              _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Reviews extends ConsumerWidget {
  const _Reviews({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(productReviewsProvider(productId));
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: context.l10n.reviews,
            onSeeAll: reviews.length > 1
                ? () => showReviewsSheet(context, reviews)
                : null,
          ),
          if (reviews.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.m),
            ReviewTile(review: reviews.first),
          ],
        ],
      ),
    );
  }
}

class _Related extends ConsumerWidget {
  const _Related({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(relatedProductsProvider(productId));
    if (products.isEmpty) return const SizedBox(height: AppSpacing.l);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.m,
            ),
            child: SectionHeader(title: context.l10n.relatedProducts),
          ),
          const SizedBox(height: AppSpacing.m),
          SizedBox(
            height: ProductCard.heightFor(
              ShopDimens.relatedCardWidth,
              MediaQuery.textScalerOf(context),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.m,
              ),
              itemCount: products.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.m),
              itemBuilder: (context, index) => SizedBox(
                width: ShopDimens.relatedCardWidth,
                child: ProductCard(
                  product: products[index],
                  onTap: () =>
                      context.push(AppRoutes.productOf(products[index].id)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
