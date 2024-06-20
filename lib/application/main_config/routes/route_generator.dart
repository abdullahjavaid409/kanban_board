import 'package:go_router/go_router.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/home_screen.dart';
import 'package:kanban_board/ui/home_screen/kan_board_detail_screen/kanboard_detail_screen.dart';

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
          card: state.extra as KanBoardCardModel,
        ),
      ),
    ],
  );
}
