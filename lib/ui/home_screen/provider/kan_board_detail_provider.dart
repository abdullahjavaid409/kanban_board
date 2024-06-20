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

final timerProvider = StateNotifierProvider.family
    .autoDispose<TimerNotifier, Duration, KanBoardCardModel>((ref, card) {
  return TimerNotifier(card);
});
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
    print("Comment added: $comment. Total comments: ${state.length}");
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
