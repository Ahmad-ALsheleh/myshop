import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dev/presentation/screens/widget_gallery_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.widgetGallery,
    routes: [
      GoRoute(
        path: AppRoutes.widgetGallery,
        builder: (context, state) => const WidgetGalleryScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
