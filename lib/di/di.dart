import 'package:get_it/get_it.dart';
import 'package:kanban_board/application/network/remote_client/api_service.dart';
import 'package:kanban_board/application/network/remote_client/iApService.dart';

final inject = GetIt.instance;

Future<void> setupLocator() async {
  inject.registerLazySingleton<IApiService>(() => ApiService());
}
