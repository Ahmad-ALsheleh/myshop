import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../profile/data/models/address.dart';
import '../../../profile/data/models/payment_card.dart';
import '../../../profile/presentation/widgets/card_network_logo.dart';
import '../../data/models/delivery_method.dart';

/// "📍 Shipping Address" title + its content.
class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          spacing: AppSpacing.m,
          children: [
            GradientIcon(icon),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.headline.copyWith(
                  color: context.palette.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: ShopDimens.sectionTitleToCard),
        child,
      ],
    );
  }
}

/// White rounded card of the checkout screen.
class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    super.key,
    required this.child,
    this.isSelected = false,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.m),
  });

  final Widget child;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: kThemeChangeDuration,
        padding: padding,
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(AppRadius.s),
          border: Border.all(
            width: AppSizes.selectedBorder,
            color: isSelected ? palette.accent : Colors.transparent,
          ),
          boxShadow: AppShadows.soft(palette),
        ),
        child: child,
      ),
    );
  }
}

/// "Change >" link.
class ChangeLink extends StatelessWidget {
  const ChangeLink({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.palette.link;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.change,
            style: AppTextStyles.label.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Icon(Icons.chevron_right, size: AppSizes.chevron, color: color),
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address, required this.onChange});

  final Address address;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final lineStyle = AppTextStyles.body.copyWith(color: palette.textBody);
    return CheckoutCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.m,
        AppSpacing.s,
        AppSpacing.m,
        AppSpacing.m,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.fullName,
                  style: AppTextStyles.body.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(address.street, style: lineStyle),
                Text(address.cityLine, style: lineStyle),
              ],
            ),
          ),
          ChangeLink(onTap: onChange),
        ],
      ),
    );
  }
}

class DeliveryMethodCard extends StatelessWidget {
  const DeliveryMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final DeliveryMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isSelected,
      label: method.name,
      child: CheckoutCard(
        isSelected: isSelected,
        onTap: onTap,
        padding: EdgeInsets.zero,
        // A minimum (not fixed) height: the card grows with big text.
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight:
                ShopDimens.deliveryCardHeight - AppSizes.selectedBorder * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(method.logo, height: ShopDimens.deliveryLogoHeight),
              const SizedBox(height: AppSpacing.s),
              Text(
                formatPrice(method.price),
                style: AppTextStyles.title.copyWith(color: palette.textPrimary),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  context.l10n.deliveryDays(method.minDays, method.maxDays),
                  maxLines: 1,
                  style: AppTextStyles.body.copyWith(
                    color: palette.textSecondary,
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

class PaymentCardTile extends StatelessWidget {
  const PaymentCardTile({
    super.key,
    required this.card,
    required this.onChange,
  });

  final PaymentCard card;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      child: Row(
        spacing: AppSpacing.s,
        children: [
          CardNetworkLogo(network: card.network),
          Expanded(child: MaskedCardNumber(last4: card.last4)),
          ChangeLink(onTap: onChange),
        ],
      ),
    );
  }
}

/// "**** **** **** 5678", always left to right.
class MaskedCardNumber extends StatelessWidget {
  const MaskedCardNumber({super.key, required this.last4});

  final String last4;

  @override
  Widget build(BuildContext context) {
    return Text(
      '**** **** **** $last4',
      textDirection: TextDirection.ltr,
      style: AppTextStyles.body.copyWith(
        color: context.palette.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.fade,
    );
  }
}

/// Grey "Items ........ $239.98" line of the summary.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body.copyWith(
      color: context.palette.textSecondary,
    );
    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(formatPrice(amount), style: style),
      ],
    );
  }
}
