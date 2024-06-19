import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/application/app.dart';
import 'package:kanban_board/common/logger/log.dart';
import 'package:kanban_board/di/di.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const ProviderScope(child: KanbanBoard()));
  }, (error, stackTrace) async {
    d('ZonedGuardedError:  ${error.toString()} $stackTrace');
  });
}
