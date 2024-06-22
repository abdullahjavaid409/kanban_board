import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/application/main_config/routes/route_generator.dart';
import 'package:kanban_board/constant/theme/theme.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp.router(
        title: 'KanbanBoard',
        theme: AppTheme.lightTheme(context),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
