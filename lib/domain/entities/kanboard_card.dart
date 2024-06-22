class KanbanCard {
  final String title;
  final String description;
  final int timeSpent;
  final List<String> comments;
  final DateTime? startTime;

  KanbanCard({
    required this.title,
    this.description = '',
    this.timeSpent = 0,
    this.comments = const [],
    this.startTime,
  });
}
