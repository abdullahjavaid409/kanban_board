import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';

final appFlowyBoardControllerProvider =
    Provider<AppFlowyBoardController>((ref) {
  final controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  final group1 = AppFlowyGroupData(id: "To Do", name: "To Do", items: [
    KanBoardCardModel(title: "Card 1"),
    KanBoardCardModel(title: "Card 2"),
  ]);

  final group2 = AppFlowyGroupData(
    id: "In Progress",
    name: "In Progress",
    items: <AppFlowyGroupItem>[
      KanBoardCardModel(title: "Card 3"),
      KanBoardCardModel(title: "Card 4"),
    ],
  );

  final group3 = AppFlowyGroupData(id: "Done", name: "Done", items: [
    KanBoardCardModel(title: "Card 5"),
    KanBoardCardModel(title: "Card 6"),
  ]);

  controller.addGroup(group1);
  controller.addGroup(group2);
  controller.addGroup(group3);

  return controller;
});

final appFlowyBoardScrollControllerProvider =
    StateProvider<AppFlowyBoardScrollController>((ref) {
  return AppFlowyBoardScrollController();
});
