import 'package:appflowy_board/appflowy_board.dart';
import 'package:kanban_board/common/logger/log.dart';

class KanBoardCardModel extends AppFlowyGroupItem {
  String title;
  String description;
  int timeSpent; // Time spent in seconds
  List<String> comments;
  DateTime? startTime; // Start time for the timer

  KanBoardCardModel({
    required this.title,
    this.description = '',
    this.timeSpent = 0,
    this.comments = const [],
    this.startTime,
  });

  @override
  String get id => title;

  // Method to start the timer
  void startTimer() {
    if (startTime == null) {
      startTime = DateTime.now();
      d("Timer started at: $startTime");
    }
  }

  // Method to stop the timer and calculate time spent
  void stopTimer() {
    if (startTime != null) {
      int elapsed =
          DateTime.now().difference(startTime ?? DateTime.now()).inSeconds;
      timeSpent += elapsed;
      startTime = null;
      d("Timer stopped. Elapsed: $elapsed seconds. Total timeSpent: $timeSpent seconds");
    }
  }

  // Method to reset the timer
  void resetTimer() {
    timeSpent = 0;
    startTime = null;
    d("Timer reset. Total timeSpent: $timeSpent seconds");
  }

  // Method to get the current elapsed time if the timer is running
  int getElapsedTime() {
    if (startTime != null) {
      return timeSpent +
          DateTime.now().difference(startTime ?? DateTime.now()).inSeconds;
    } else {
      return timeSpent;
    }
  }

  // Method to add a comment
  void addComment(String comment) {
    comments = [...comments, comment];
  }
}
