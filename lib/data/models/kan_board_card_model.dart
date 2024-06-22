import 'dart:convert';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:kanban_board/domain/entities/kanboard_card.dart';

class KanbanCardModel extends KanbanCard implements AppFlowyGroupItem {
  KanbanCardModel({
    required super.title,
    super.description,
    super.timeSpent,
    super.comments,
    super.startTime,
  });

  @override
  String get id => title;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'timeSpent': timeSpent,
      'comments': jsonEncode(comments),
      'startTime': startTime?.toIso8601String(),
    };
  }

  factory KanbanCardModel.fromMap(Map<String, dynamic> map) {
    return KanbanCardModel(
      title: map['title'],
      description: map['description'],
      timeSpent: map['timeSpent'],
      comments: List<String>.from(jsonDecode(map['comments'])),
      startTime:
          map['startTime'] != null ? DateTime.parse(map['startTime']) : null,
    );
  }

  @override
  bool get draggable => true;

  @override
  bool get isPhantom => false;

  @override
  set draggable(__) {}
}
