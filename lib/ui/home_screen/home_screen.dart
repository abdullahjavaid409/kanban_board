import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kan_board_widget.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_dilaog.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_provider.dart';

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
                showAddCardDialog(context, columnData.id, ref);
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
}
