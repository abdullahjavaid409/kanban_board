import 'package:get_it/get_it.dart';
import 'package:kanban_board/di/di.dart';

final serviceLocator = GetIt.instance;
int paginationPageSize = 20;

Future<void> initMainServiceLocator() async {
  await setupLocator();
  return serviceLocator.allReady();
}
