import 'package:go_router/go_router.dart';
import 'package:kanban_board/ui/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: HomeScreen.routeName,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );
}
