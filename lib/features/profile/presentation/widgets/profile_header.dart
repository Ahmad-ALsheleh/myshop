import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/gradient_icon.dart';

/// Curved purple header with the avatar, name, phone and the edit button.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.subtitle,
    required this.avatar,
    required this.onEdit,
  });

  final String name;

  /// Phone number (or a hint for guests).
  final String subtitle;

  /// Asset path, `null` for guests.
  final String? avatar;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return CurvedHeader(
      height: ProfileDimens.headerHeight,
      curve: ProfileDimens.headerCurve,
      child: Stack(
        children: [
          PositionedDirectional(
            start: AppSpacing.m,
            top: ProfileDimens.avatarTop,
            child: Container(
              padding: const EdgeInsets.all(ProfileDimens.avatarRing),
              decoration: BoxDecoration(
                color: palette.background,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: ProfileDimens.avatar / 2,
                backgroundColor: palette.surface,
                backgroundImage: avatar == null ? null : AssetImage(avatar!),
                child: avatar == null
                    ? const GradientIcon(
                        Icons.person,
                        size: ProfileDimens.avatar / 2,
                      )
                    : null,
              ),
            ),
          ),
          PositionedDirectional(
            start: ProfileDimens.nameStart,
            end: ProfileDimens.editButton + AppSpacing.m * 2,
            top: ProfileDimens.nameTop,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headline.copyWith(
                    color: palette.onAccent,
                  ),
                ),
                Text(
                  subtitle,
                  textDirection: TextDirection.ltr,
                  style: AppTextStyles.body.copyWith(color: palette.onAccent),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            PositionedDirectional(
              end: AppSpacing.m,
              top: ProfileDimens.editButtonTop,
              child: Semantics(
                button: true,
                label: context.l10n.editProfile,
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    width: ProfileDimens.editButton,
                    height: ProfileDimens.editButton,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: palette.surface,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.soft(palette),
                    ),
                    child: const GradientIcon(Icons.edit_outlined),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
