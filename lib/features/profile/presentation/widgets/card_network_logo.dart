import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/payment_card.dart';

/// Logo of a card network (checkout, payment methods).
class CardNetworkLogo extends StatelessWidget {
  const CardNetworkLogo({super.key, required this.network});

  final CardNetwork network;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ShopDimens.cardLogoWidth,
      child: switch (network) {
        CardNetwork.mastercard => Image.asset(AppImages.mastercard),
        // No Visa artwork in the design: the brand name as a wordmark.
        CardNetwork.visa => Text(
          'VISA',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: AppTextStyles.title.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            color: context.palette.link,
          ),
        ),
      },
    );
  }
}
