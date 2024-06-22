import 'package:kanban_board/domain/entities/kanboard_card.dart';
import 'package:kanban_board/domain/repository/kanboard_repository.dart';

class UpdateKanbanCard {
  final KanbanRepository repository;

  UpdateKanbanCard(this.repository);

  Future<void> execute(KanbanCard card) async {
    return await repository.updateCard(card);
  }
}
