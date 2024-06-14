import 'package:appflowy_board/appflowy_board.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/ui/home_screen/home_screen.dart';
import 'package:kanban_board/ui/kanboard_detail_screen.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: HomeScreen.routeName,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: KanBoardDetailScreen.routeName,
        builder: (_, state) => KanBoardDetailScreen(
          item: state.extra as AppFlowyGroupItem?,
        ),
      ),
    ],
  );
}
