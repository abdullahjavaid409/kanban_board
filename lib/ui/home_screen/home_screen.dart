import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kan_board_widget.dart';

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
    Provider<AppFlowyBoardScrollController>((ref) {
  return AppFlowyBoardScrollController();
});

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(appFlowyBoardControllerProvider);
    final boardController = ref.watch(appFlowyBoardScrollControllerProvider);

    const config = AppFlowyBoardConfig(
      groupBackgroundColor: Colors.white,
      boardCornerRadius: 12,
      stretchGroupHeight: false,
    );

    final allCards = controller.groupDatas
        .expand((group) => group.items)
        .whereType<KanBoardCardModel>()
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AppFlowyBoard(
          controller: controller,
          cardBuilder: (context, group, groupItem) {
            return AppFlowyGroupCard(
              key: ValueKey(groupItem.id),
              child: KanBoardCardWidget(
                cardModel: groupItem as KanBoardCardModel,
                onEdit: (newTitle) {
                  groupItem.title = newTitle;
                  // Notify the controller that the item has changed
                  controller.notifyListeners();
                },
                onPressed: (BuildContext context) {},
                allCards: allCards,
              ),
            );
          },
          boardScrollController: boardController,
          footerBuilder: (context, columnData) {
            return AppFlowyGroupFooter(
              icon: const Icon(Icons.add, size: 20),
              title: const Text('New'),
              height: 50.h,
              margin: config.groupBodyPadding,
              onAddButtonClick: () {
                _showAddCardDialog(context, columnData.id, ref);
              },
            );
          },
          headerBuilder: (context, columnData) {
            return AppFlowyGroupHeader(
              icon: const Icon(Icons.lightbulb_circle),
              title: SizedBox(
                width: 90.w,
                child: TextField(
                  controller: TextEditingController()
                    ..text = columnData.headerData.groupName,
                  onSubmitted: (val) {
                    controller
                        .getGroupController(columnData.headerData.groupId)!
                        .updateGroupName(val);
                  },
                ),
              ),
              height: 50.h,
              margin: config.groupBodyPadding,
            );
          },
          groupConstraints: BoxConstraints.tightFor(width: 240.w),
          config: config,
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context, String groupId, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New KanBoard Card'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter card title',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final title = titleController.text;

                if (title.isNotEmpty) {
                  final controller = ref.read(appFlowyBoardControllerProvider);

                  // Check for duplicate names across all groups
                  final isDuplicate = controller.groupDatas.any((group) =>
                      group.items.whereType<KanBoardCardModel>().any((card) =>
                          card.title.toLowerCase() == title.toLowerCase()));

                  if (isDuplicate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Card with the same title already exists'),
                      ),
                    );
                    return;
                  }

                  final groupController =
                      controller.getGroupController(groupId);
                  if (groupController == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Group not found'),
                      ),
                    );
                    return;
                  }

                  final newItem = KanBoardCardModel(
                    title: title,
                  );
                  groupController.add(newItem);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
