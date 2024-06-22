import 'package:kanban_board/domain/repository/kanboard_repository.dart';

class DeleteKanbanCard {
  final KanbanRepository repository;

  DeleteKanbanCard(this.repository);

  Future<void> execute(String title) async {
    return await repository.deleteCard(title);
  }
}
