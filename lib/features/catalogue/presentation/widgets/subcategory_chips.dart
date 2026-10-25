import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/category.dart';

/// "All · Dresses · Tops · ..." pills of the items screen.
class SubcategoryChips extends StatelessWidget {
  const SubcategoryChips({
    super.key,
    required this.subcategories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<Subcategory> subcategories;

  /// `null` = "All".
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final chips = [
      (null, context.l10n.all),
      for (final subcategory in subcategories)
        (subcategory.id, context.localize(subcategory.name)),
    ];
    return SizedBox(
      height: CatalogueDimens.chipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.m,
        ),
        itemCount: chips.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: CatalogueDimens.chipGap),
        itemBuilder: (context, index) {
          final (id, label) = chips[index];
          return _Chip(
            label: label,
            isSelected: id == selectedId,
            onTap: () => onSelected(id),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: kThemeChangeDuration,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: CatalogueDimens.chipPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected ? palette.accent : palette.surface,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isSelected ? palette.onAccent : palette.textBody,
            ),
          ),
        ),
      ),
    );
  }
}
