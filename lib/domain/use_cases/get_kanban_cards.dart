import 'package:kanban_board/domain/repository/kanboard_repository.dart';

import '../entities/kanboard_card.dart';

class GetKanbanCards {
  final KanbanRepository repository;

  GetKanbanCards(this.repository);

  Future<List<KanbanCard>> execute() async {
    return await repository.getCards();
  }
}
