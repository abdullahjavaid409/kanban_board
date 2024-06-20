import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/common/logger/log.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';

final timerProvider =
    StateNotifierProvider.family<TimerNotifier, Duration, KanBoardCardModel>(
        (ref, card) {
  return TimerNotifier(card);
});

class TimerNotifier extends StateNotifier<Duration> {
  final KanBoardCardModel card;
  Timer? _timer;

  TimerNotifier(this.card) : super(Duration(seconds: card.getElapsedTime())) {
    if (card.startTime != null) {
      _startTimer();
    }
  }

  void start() {
    if (_timer != null) return;
    card.startTimer();
    d('Timer started for card: ${card.title}');
    _startTimer();
  }

  void stop() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      card.stopTimer();
      state = Duration(seconds: card.timeSpent);
      d('Timer stopped for card: ${card.title}, time spent: ${state.inSeconds}s');
    }
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    card.resetTimer();
    state = Duration.zero;
    d('Timer reset for card: ${card.title}');
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = Duration(seconds: card.getElapsedTime());
      d('Timer updated for card: ${card.title}, time: ${state.inSeconds}s');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final commentsProvider = StateNotifierProvider.family<CommentsNotifier,
    List<String>, KanBoardCardModel>((ref, card) {
  return CommentsNotifier(card);
});

class CommentsNotifier extends StateNotifier<List<String>> {
  final KanBoardCardModel card;

  CommentsNotifier(this.card) : super(card.comments);

  void addComment(String comment) {
    card.comments = [...state, comment]; // Update the model's comments
    state = card.comments; // Update the state to trigger a rebuild
    d("Comment added: $comment. Total comments: ${state.length}");
  }
}

final descriptionProvider = StateNotifierProvider.family<DescriptionNotifier,
    String, KanBoardCardModel>((ref, card) {
  return DescriptionNotifier(card);
});

class DescriptionNotifier extends StateNotifier<String> {
  final KanBoardCardModel card;

  DescriptionNotifier(this.card) : super(card.description);

  void updateDescription(String newDescription) {
    card.description = newDescription;
    state = newDescription;
  }
}
