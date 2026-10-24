import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dev/presentation/screens/foundation_preview_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.foundationPreview,
    routes: [
      GoRoute(
        path: AppRoutes.foundationPreview,
        builder: (context, state) => const FoundationPreviewScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
