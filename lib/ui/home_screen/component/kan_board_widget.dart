import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/constants.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/widgets/common_widget.dart';

class KanBoardCardWidget extends StatelessWidget {
  final KanBoardCardModel cardModel;
  final BuildContextCallback onPressed;
  final Function(String) onEdit;

  const KanBoardCardWidget({
    super.key,
    required this.cardModel,
    required this.onEdit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(context),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      cardModel.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () {
                      _showEditCardDialog(context, cardModel);
                    },
                    icon: Icon(Icons.edit, size: 15.h),
                  ),
                ],
              ),
              const VerticalSpacing(of: 5),
              Text(
                cardModel.description ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const VerticalSpacing(of: 10),
              Row(
                children: [
                  IconTitleWidget(
                    title: cardModel.logHour != null
                        ? cardModel.logHour ?? ''
                        : "Log hour ...",
                  ),
                  const Spacer(),
                  if (cardModel.chatLength != null)
                    IconTitleWidget(
                      icon: Icons.chat_bubble_outline,
                      title: '${cardModel.chatLength ?? 0} Chats',
                    ),
                ],
              ),
              const VerticalSpacing(of: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditCardDialog(BuildContext context, KanBoardCardModel cardModel) {
    final TextEditingController titleController = TextEditingController()
      ..text = cardModel.title;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit KanBoard Card'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter new card title',
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
}

class IconTitleWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const IconTitleWidget({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon ?? Icons.watch_later_outlined, size: 15.sp),
        const HorizontalSpacing(of: 5),
        Text(title ?? "Log ...")
      ],
    );
  }
}
