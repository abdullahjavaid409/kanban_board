import 'package:sqflite/sqflite.dart';

import '../../application/core/database_helper/data_base_helper.dart';
import '../models/kan_board_card_model.dart';

class KanbanLocalDataSource {
  final DatabaseHelper databaseHelper;

  KanbanLocalDataSource(this.databaseHelper);

  Future<void> insertCard(KanbanCardModel card) async {
    final db = await databaseHelper.database;
    await db.insert('cards', card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCard(KanbanCardModel card) async {
    final db = await databaseHelper.database;
    await db.update('cards', card.toMap(),
        where: 'title = ?', whereArgs: [card.title]);
  }

  Future<void> deleteCard(String title) async {
    final db = await databaseHelper.database;
    await db.delete('cards', where: 'title = ?', whereArgs: [title]);
  }

  Future<List<KanbanCardModel>> getCards() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('cards');
    return List.generate(maps.length, (i) {
      return KanbanCardModel.fromMap(maps[i]);
    });
  }
}
