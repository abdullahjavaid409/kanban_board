import 'package:get_it/get_it.dart';
import 'package:kanban_board/application/core/database_helper/data_base_helper.dart';
import 'package:kanban_board/application/network/remote_client/api_service.dart';
import 'package:kanban_board/application/network/remote_client/iApService.dart';
import 'package:kanban_board/data/repository/kanban_repository_impl.dart';
import 'package:kanban_board/domain/use_cases/delete_kanban_card.dart';
import 'package:kanban_board/domain/use_cases/get_kanban_cards.dart';
import 'package:kanban_board/domain/use_cases/update_kanban_card.dart';

import '../data/local_data_source/kanban_local_data_source.dart';
import '../domain/repository/kanboard_repository.dart';
import '../domain/use_cases/add_kanban_card.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<IApiService>(() => ApiService());
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  getIt.registerLazySingleton<KanbanRepository>(
      () => KanbanRepositoryImpl(getIt<KanbanLocalDataSource>()));
  getIt.registerLazySingleton<AddKanbanCard>(
      () => AddKanbanCard(getIt<KanbanRepository>()));
  getIt.registerLazySingleton<UpdateKanbanCard>(
      () => UpdateKanbanCard(getIt<KanbanRepository>()));
  getIt.registerLazySingleton<DeleteKanbanCard>(
      () => DeleteKanbanCard(getIt<KanbanRepository>()));
  getIt.registerLazySingleton<GetKanbanCards>(
      () => GetKanbanCards(getIt<KanbanRepository>()));
}
