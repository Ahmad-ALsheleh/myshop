import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/session_provider.dart';
import '../../features/auth/presentation/screens/phone_screen.dart';
import '../../features/auth/presentation/screens/verification_screen.dart';
import '../../features/dev/presentation/screens/widget_gallery_screen.dart';
import '../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Re-runs the redirect when the onboarding or session state changes
  // (Get Started, Skip, sign in, log out).
  final refresh = ValueNotifier(0);
  void onChange(Object? _, Object? _) => refresh.value++;
  ref
    ..listen(onboardingSeenProvider, onChange)
    ..listen(canEnterAppProvider, onChange);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) => AppRoutes.redirect(
      state.matchedLocation,
      onboardingSeen: ref.read(onboardingSeenProvider),
      canEnterApp: ref.read(canEnterAppProvider),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.phone,
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: AppRoutes.verification,
        builder: (context, state) => VerificationScreen(
          phone:
              state.uri.queryParameters[AppRoutes.verificationPhoneParam] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const WidgetGalleryScreen(),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});
