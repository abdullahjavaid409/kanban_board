import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/domain/repository/kanboard_repository.dart';

import '../../domain/entities/kanboard_card.dart';
import '../local_data_source/kanban_local_data_source.dart';

class KanbanRepositoryImpl implements KanbanRepository {
  final KanbanLocalDataSource localDataSource;

  KanbanRepositoryImpl(this.localDataSource);

  @override
  Future<void> addCard(KanbanCard card) async {
    return await localDataSource.insertCard(KanbanCardModel(
      title: card.title,
      description: card.description,
      timeSpent: card.timeSpent,
      comments: card.comments,
      startTime: card.startTime,
    ));
  }

  @override
  Future<void> updateCard(KanbanCard card) async {
    return await localDataSource.updateCard(KanbanCardModel(
      title: card.title,
      description: card.description,
      timeSpent: card.timeSpent,
      comments: card.comments,
      startTime: card.startTime,
    ));
  }

  @override
  Future<void> deleteCard(String title) async {
    return await localDataSource.deleteCard(title);
  }

  @override
  Future<List<KanbanCard>> getCards() async {
    return await localDataSource.getCards();
  }
}
