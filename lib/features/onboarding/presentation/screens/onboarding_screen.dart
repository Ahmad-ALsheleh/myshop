import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/onboarding_provider.dart';

/// "Get Started": full-screen photo with the purple panel at the bottom.
/// Shown on the first launch only.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelHeight =
        AuthDimens.panelHeight + MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            // The photo continues under the rounded corners of the panel.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: panelHeight - AuthDimens.panelRadius,
              child: Image.asset(
                AppImages.onboarding,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _Panel(
                height: panelHeight,
                onGetStarted: () =>
                    ref.read(onboardingSeenProvider.notifier).set(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.height, required this.onGetStarted});

  final double height;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: palette.brandGradient,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AuthDimens.panelRadius),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AuthDimens.logoTop),
          const AppLogo(fontSize: AuthDimens.logoSize),
          const SizedBox(height: AuthDimens.logoToText),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AuthDimens.textInset,
            ),
            child: Text(
              context.l10n.onboardingSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(color: palette.onAccent),
            ),
          ),
          const SizedBox(height: AuthDimens.textToButton),
          SizedBox(
            width: AuthDimens.buttonWidth,
            child: PrimaryButton(
              label: context.l10n.getStarted,
              onPressed: onGetStarted,
            ),
          ),
        ],
      ),
    );
  }
}
