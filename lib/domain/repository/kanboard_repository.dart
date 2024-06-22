import '../entities/kanboard_card.dart';

abstract class KanbanRepository {
  Future<void> addCard(KanbanCard card);
  Future<void> updateCard(KanbanCard card);
  Future<void> deleteCard(String title);
  Future<List<KanbanCard>> getCards();
}
