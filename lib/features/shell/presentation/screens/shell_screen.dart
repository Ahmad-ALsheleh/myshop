import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../widgets/app_bottom_navigation.dart';

/// Frame of the 4 main tabs: the current tab + the bottom navigation.
/// Each tab keeps its own navigation stack (go_router StatefulShellRoute).
class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The content shows through the strip next to the cart pill.
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        // Tapping the current tab again goes back to its first screen.
        onTabSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        onCartTap: () => context.push(AppRoutes.cart),
      ),
    );
  }
}
