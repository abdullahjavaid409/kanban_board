import 'package:appflowy_board/appflowy_board.dart';

class KanBoardCardModel extends AppFlowyGroupItem {
  String title;
  String? description;
  String? logHour;
  int? chatLength;
  int timeSpent;
  List<String> comments;
  DateTime? completedDate;

  KanBoardCardModel({
    required this.title,
    this.description,
    this.chatLength,
    this.logHour,
    this.timeSpent = 0,
    this.comments = const [],
  });

  @override
  String get id => title;
}
