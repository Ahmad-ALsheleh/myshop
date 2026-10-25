import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/menu_tile.dart';
import '../../../auth/data/models/country.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../../../auth/presentation/providers/sign_in_providers.dart';
import '../widgets/profile_header.dart';

/// Profile tab: header with the user and the menu.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogOut(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l10n.logOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.logOut),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await ref.read(sessionProvider.notifier).signOut();
  }

  void _showPrivacyPolicy(BuildContext context) {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.privacyPolicy),
        content: Text(l10n.privacyPolicyBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final user = ref.watch(sessionProvider);
    // The bottom padding already contains the navigation (extendBody),
    // including the strip the cart pill rises into.
    final bottomSpace =
        MediaQuery.paddingOf(context).bottom -
        AppSizes.cartPillRise +
        ProfileDimens.privacyBottom;

    final menu = [
      // The next screens are connected when they are built.
      (Icons.location_on_outlined, l10n.shippingAddresses, null),
      (Icons.credit_card_outlined, l10n.paymentMethods, null),
      (
        Icons.assignment_outlined,
        l10n.orders,
        () => context.push(AppRoutes.orders),
      ),
      (
        Icons.favorite_border,
        l10n.navFavorite,
        () => context.go(AppRoutes.favorites),
      ),
      (Icons.settings_outlined, l10n.settings, null),
      if (user == null)
        (
          Icons.login,
          l10n.signIn,
          () => ref.read(sessionProvider.notifier).signOut(),
        )
      else
        (Icons.logout, l10n.logOut, () => _confirmLogOut(context, ref)),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeader(
                    name: user?.name ?? l10n.guest,
                    subtitle: user == null
                        ? l10n.signIn
                        : ref
                              .watch(countriesProvider)
                              .displayNumber(user.phone),
                    avatar: user?.avatar,
                    onEdit: user == null ? null : () {},
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.m,
                      ProfileDimens.menuTop,
                      AppSpacing.m,
                      AppSpacing.l,
                    ),
                    child: Column(
                      spacing: ProfileDimens.menuItemGap,
                      children: [
                        for (final (icon, label, onTap) in menu)
                          MenuTile(icon: icon, label: label, onTap: onTap),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppSpacing.m,
                      bottom: bottomSpace,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: () => _showPrivacyPolicy(context),
                        child: Text(
                          l10n.privacyPolicy,
                          style: AppTextStyles.body.copyWith(
                            color: palette.textBody,
                            decoration: TextDecoration.underline,
                            decorationColor: palette.textBody,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
