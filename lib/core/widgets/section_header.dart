import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// "Catalogue ............ See All >" row.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onSeeAll});

  final String title;

  /// Shows "See All" when set.
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.headline.copyWith(color: palette.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Text(
                  context.l10n.seeAll,
                  style: AppTextStyles.label.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: AppSizes.chevron,
                  color: palette.textSecondary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
