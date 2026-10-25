import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/category.dart';

/// Square photo with the category name on it (home "Catalogue" row).
class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xs),
        child: SizedBox.square(
          dimension: CatalogueDimens.tileSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(category.image, fit: BoxFit.cover),
              ColoredBox(color: palette.imageOverlay),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(CatalogueDimens.tileTextInset),
                  child: Text(
                    context.localize(category.name),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.tileLabel.copyWith(
                      color: palette.onAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
