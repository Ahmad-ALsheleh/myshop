import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/category.dart';

/// Row of the catalogue screen: name at the start, photo at the end.
class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: CatalogueDimens.cardHeight,
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(AppRadius.s),
          boxShadow: AppShadows.soft(palette),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: CatalogueDimens.cardTextStart,
                ),
                child: Text(
                  context.localize(category.name),
                  style: AppTextStyles.title.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadiusDirectional.horizontal(
                end: Radius.circular(AppRadius.s),
              ),
              child: Image.asset(
                category.image,
                width: CatalogueDimens.cardHeight,
                height: CatalogueDimens.cardHeight,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
