import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_panel.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/addresses_provider.dart';
import '../widgets/saved_item_tile.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final addresses = ref.watch(addressesProvider);
    final notifier = ref.read(addressesProvider.notifier);
    final lineStyle = AppTextStyles.body.copyWith(color: palette.textBody);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(title: l10n.shippingAddresses),
          Expanded(
            child: addresses.isEmpty
                ? EmptyState(
                    icon: Icons.location_on_outlined,
                    message: l10n.noAddresses,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    itemCount: addresses.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.m),
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return SavedItemTile(
                        isDefault: address.isDefault,
                        onSelect: () => notifier.setDefault(address.id),
                        onEdit: () =>
                            context.push(AppRoutes.addressFormOf(address.id)),
                        onDelete: () async {
                          final confirmed = await showConfirmDialog(
                            context,
                            message: l10n.deleteAddressConfirm,
                            confirmLabel: l10n.delete,
                          );
                          if (confirmed) notifier.remove(address.id);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.fullName,
                              style: lineStyle.copyWith(
                                color: palette.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(address.street, style: lineStyle),
                            Text(address.cityLine, style: lineStyle),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPanel(
        child: PrimaryButton(
          label: l10n.addAddress,
          onPressed: () => context.push(AppRoutes.addressFormOf(null)),
        ),
      ),
    );
  }
}
