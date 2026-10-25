import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_logo.dart';
import '../providers/catalogue_providers.dart';

/// Side menu of the home screen (☰): quick access to every category.
class CategoriesDrawer extends ConsumerWidget {
  const CategoriesDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final categories = ref.watch(categoriesProvider);
    return Drawer(
      backgroundColor: palette.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(
              start: AppSpacing.m,
              top: MediaQuery.paddingOf(context).top + AppSpacing.l,
              bottom: AppSpacing.l,
            ),
            decoration: BoxDecoration(gradient: palette.brandGradient),
            child: const Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppLogo(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (final category in categories)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(category.image),
                    ),
                    title: Text(
                      context.localize(category.name),
                      style: AppTextStyles.body.copyWith(
                        color: palette.textPrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.categoryItemsOf(category.id));
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
