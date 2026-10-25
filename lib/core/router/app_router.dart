import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/session_provider.dart';
import '../../features/auth/presentation/screens/phone_screen.dart';
import '../../features/auth/presentation/screens/verification_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/catalogue/presentation/screens/catalogue_screen.dart';
import '../../features/catalogue/presentation/screens/filter_screen.dart';
import '../../features/catalogue/presentation/screens/items_screen.dart';
import '../../features/catalogue/presentation/screens/search_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/product/presentation/screens/product_screen.dart';
import '../../features/profile/presentation/screens/address_form_screen.dart';
import '../../features/profile/presentation/screens/addresses_screen.dart';
import '../../features/profile/presentation/screens/card_form_screen.dart';
import '../../features/profile/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/payment_methods_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/shell/presentation/screens/shell_screen.dart';
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
      // The 4 tabs; each one keeps its own stack (and scroll position).
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShellScreen(navigationShell: navigationShell),
        branches: [
          _tab(AppRoutes.home, const HomeScreen()),
          _tab(
            AppRoutes.catalogue,
            const CatalogueScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.categoryItems,
                builder: (context, state) => ItemsScreen(
                  categoryId: state.pathParameters[AppRoutes.categoryIdParam]!,
                ),
              ),
            ],
          ),
          _tab(AppRoutes.favorites, const FavoritesScreen()),
          _tab(AppRoutes.profile, const ProfileScreen()),
        ],
      ),
      // Full screen pages, above the bottom navigation.
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) => ProductScreen(
          productId: state.pathParameters[AppRoutes.productIdParam]!,
        ),
      ),
      GoRoute(
        path: AppRoutes.filter,
        builder: (context, state) => FilterScreen(
          categoryId: state.pathParameters[AppRoutes.categoryIdParam]!,
        ),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addresses,
        builder: (context, state) => const AddressesScreen(),
      ),
      GoRoute(
        path: AppRoutes.addressForm,
        builder: (context, state) => AddressFormScreen(
          addressId: state.uri.queryParameters[AppRoutes.addressIdParam],
        ),
      ),
      GoRoute(
        path: AppRoutes.paymentMethods,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: AppRoutes.cardForm,
        builder: (context, state) => const CardFormScreen(),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});

StatefulShellBranch _tab(
  String path,
  Widget screen, {
  List<RouteBase> routes = const [],
}) => StatefulShellBranch(
  routes: [
    GoRoute(path: path, builder: (context, state) => screen, routes: routes),
  ],
);
