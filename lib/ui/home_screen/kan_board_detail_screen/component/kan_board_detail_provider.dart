import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';

class TimerNotifier extends StateNotifier<Duration> {
  TimerNotifier(this.card) : super(Duration(seconds: card.timeSpent));

  final KanBoardCardModel card;
  Timer? _timer;

  void start() {
    if (_timer != null) return;
    card.startTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = Duration(seconds: card.getElapsedTime());
    });
  }

  void stop() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      card.stopTimer();
      state = Duration(seconds: card.timeSpent);
    }
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    card.resetTimer();
    state = Duration.zero;
  }

  void setTrackedTime(Duration trackedTime) {
    card.timeSpent = trackedTime.inSeconds;
    state = trackedTime;
  }
}

final timerProvider =
    StateNotifierProvider.family<TimerNotifier, Duration, KanBoardCardModel>(
        (ref, card) {
  return TimerNotifier(card);
});

final commentsProvider = StateNotifierProvider.family<CommentsNotifier,
    List<String>, KanBoardCardModel>((ref, card) {
  return CommentsNotifier(card.comments);
});

class CommentsNotifier extends StateNotifier<List<String>> {
  CommentsNotifier(super.initialComments);

  void addComment(String comment) {
    state = [...state, comment];
  }
}
