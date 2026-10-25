import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/promo_banner.dart';

/// "Fashion Sale / See More" slides. They advance by themselves; the bars at
/// the bottom fill up like stories while a slide is shown.
class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({
    super.key,
    required this.banners,
    required this.onBannerTap,
  });

  final List<PromoBanner> banners;
  final ValueChanged<PromoBanner> onBannerTap;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel>
    with SingleTickerProviderStateMixin {
  final _pages = PageController();
  late final _progress =
      AnimationController(vsync: this, duration: CatalogueDimens.bannerInterval)
        ..addStatusListener(_onSlideShown)
        ..forward();
  var _index = 0;

  void _onSlideShown(AnimationStatus status) {
    if (status != AnimationStatus.completed || !_pages.hasClients) return;
    final next = (_index + 1) % widget.banners.length;
    _pages.animateToPage(
      next,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
    _progress.forward(from: 0);
  }

  @override
  void dispose() {
    _progress.dispose();
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CatalogueDimens.bannerHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.s),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pages,
              itemCount: widget.banners.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) => _BannerSlide(
                banner: widget.banners[index],
                onTap: () => widget.onBannerTap(widget.banners[index]),
              ),
            ),
            PositionedDirectional(
              start: CatalogueDimens.bannerIndicatorInset,
              end: CatalogueDimens.bannerIndicatorInset,
              bottom: CatalogueDimens.bannerIndicatorBottom,
              child: AnimatedBuilder(
                animation: _progress,
                builder: (context, _) => _ProgressBars(
                  count: widget.banners.length,
                  index: _index,
                  progress: _progress.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerSlide extends StatelessWidget {
  const _BannerSlide({required this.banner, required this.onTap});

  final PromoBanner banner;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(banner.image, fit: BoxFit.cover),
          // Keeps the white title readable on light photos.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [palette.imageOverlay, Colors.transparent],
              ),
            ),
          ),
          PositionedDirectional(
            start: CatalogueDimens.bannerTextStart,
            top: CatalogueDimens.bannerTitleTop,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localize(banner.title),
                  style: AppTextStyles.bannerTitle.copyWith(
                    color: palette.onAccent,
                  ),
                ),
                const SizedBox(height: CatalogueDimens.bannerTitleToLink),
                Row(
                  children: [
                    Text(
                      context.l10n.seeMore,
                      style: AppTextStyles.label.copyWith(
                        color: palette.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: AppSizes.chevron,
                      color: palette.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBars extends StatelessWidget {
  const _ProgressBars({
    required this.count,
    required this.index,
    required this.progress,
  });

  final int count;
  final int index;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final color = context.palette.onAccent;
    return Row(
      spacing: CatalogueDimens.bannerIndicatorGap,
      children: [
        for (var i = 0; i < count; i++)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: i < index ? 1 : (i == index ? progress : 0),
                minHeight: CatalogueDimens.bannerIndicatorHeight,
                color: color,
                backgroundColor: color.withValues(alpha: 0.35),
              ),
            ),
          ),
      ],
    );
  }
}
