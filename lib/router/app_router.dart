import 'package:go_router/go_router.dart';

import '../presentation/screen1_mood/mood_screen.dart';
import '../presentation/screen2_health/health_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/mood',
    routes: [
      GoRoute(
        path: '/mood',
        builder: (context, state) => const MoodScreen(),
      ),
      GoRoute(
        path: '/health',
        builder: (context, state) => const HealthScreen(),
      ),
    ],
  );
}
