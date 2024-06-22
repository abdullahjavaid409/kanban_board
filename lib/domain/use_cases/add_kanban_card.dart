import '../entities/kanboard_card.dart';
import '../repository/kanboard_repository.dart';

class AddKanbanCard {
  final KanbanRepository repository;

  AddKanbanCard(this.repository);

  Future<void> execute(KanbanCard card) async {
    return await repository.addCard(card);
  }
}
