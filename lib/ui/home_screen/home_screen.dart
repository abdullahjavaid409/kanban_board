import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/widgets/common_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
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

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
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
  }

  @override
  Widget build(BuildContext context) {
    const config = AppFlowyBoardConfig(
      groupBackgroundColor: Colors.white,
      boardCornerRadius: 12,
      stretchGroupHeight: false,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AppFlowyBoard(
          controller: controller,
          cardBuilder: (context, group, groupItem) {
            return AppFlowyGroupCard(
              key: ValueKey(groupItem.id),
              child: _buildCard(groupItem),
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
                _showAddCardDialog(context, columnData.id);
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
          groupConstraints: const BoxConstraints.tightFor(width: 240),
          config: config,
        ),
      ),
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is KanBoardCardModel) {
      return KanBoardCardWidget(cardModel: item);
    }
    throw UnimplementedError();
  }

  void _showAddCardDialog(BuildContext context, String groupId) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController logHourController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New KanBoard Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter card title',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter card description (optional)',
                ),
              ),
              TextField(
                controller: logHourController,
                decoration: const InputDecoration(
                  hintText: 'Enter log hour (optional)',
                ),
              ),
            ],
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
                final description = descriptionController.text;
                final logHour = logHourController.text;

                if (title.isNotEmpty) {
                  final groupController =
                      controller.getGroupController(groupId);
                  final existingCard = groupController?.groupData.items
                      .whereType<KanBoardCardModel>()
                      .any((card) =>
                          card.title.toLowerCase() == title.toLowerCase());
                  if (existingCard == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(''),
                      ),
                    );
                  }
                  setState(() {
                    final newItem = KanBoardCardModel(
                      title: title,
                      description: description.isNotEmpty ? description : null,
                      logHour: logHour.isNotEmpty ? logHour : null,
                    );
                    controller.addGroupItem(groupId, newItem);
                  });
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

class KanBoardCardModel extends AppFlowyGroupItem {
  final String title;
  final String? description;
  final String? logHour;
  final int? chatLength;
  KanBoardCardModel({
    required this.title,
    this.description,
    this.chatLength,
    this.logHour,
  });

  @override
  String get id => title;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class KanBoardCardWidget extends StatelessWidget {
  final KanBoardCardModel cardModel;
  const KanBoardCardWidget({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              cardModel.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const VerticalSpacing(of: 5),
            Text(cardModel.description ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall),
            const VerticalSpacing(of: 10),
            Row(children: [
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
            ])
          ],
        ),
      ),
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
