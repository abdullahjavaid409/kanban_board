import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_provider.dart';

void showAddCardDialog(BuildContext context, String groupId, WidgetRef ref) {
  final TextEditingController titleController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Add Card'),
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
                      content: Text('Card with the same title already exists'),
                    ),
                  );
                  return;
                }

                final groupController = controller.getGroupController(groupId);
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

void showEditCardDialog(BuildContext context, KanBoardCardModel cardModel,
    List<KanBoardCardModel> allCards, void Function(String) onEdit) {
  final TextEditingController titleController = TextEditingController()
    ..text = cardModel.title;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Edit Card'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Enter new card title',
            hintStyle: Theme.of(context).textTheme.bodySmall,
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
            child: const Text('Save'),
            onPressed: () {
              final newTitle = titleController.text;
              if (newTitle.isNotEmpty) {
                // Check for duplicate names across all cards
                final isDuplicate = allCards.any((card) =>
                    card.title.toLowerCase() == newTitle.toLowerCase() &&
                    card != cardModel);

                if (isDuplicate) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Card with the same title already exists'),
                    ),
                  );
                  return;
                }

                onEdit(newTitle);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
