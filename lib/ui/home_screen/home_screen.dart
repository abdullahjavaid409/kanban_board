import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kan_board_widget.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_dilaog.dart';
import 'package:kanban_board/ui/home_screen/detail_screen/detail_screen.dart';
import 'package:kanban_board/ui/home_screen/provider/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(appFlowyBoardControllerProvider);
    final boardController = ref.watch(appFlowyBoardScrollControllerProvider);

    const config = AppFlowyBoardConfig(
      groupBodyPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      stretchGroupHeight: false,
    );

    final allCards = controller.groupDatas
        .expand((group) => group.items)
        .whereType<KanBoardCardModel>()
        .toList();

    return Scaffold(
      body: SafeArea(
        child: AppFlowyBoard(
          controller: controller,
          cardBuilder: (context, group, groupItem) {
            final card = groupItem as KanBoardCardModel;
            return AppFlowyGroupCard(
              decoration: const BoxDecoration(color: AppColors.backgroundColor),
              key: ValueKey(groupItem.id),
              child: KanBoardCardWidget(
                cardModel: card,
                onEdit: (newTitle) {
                  groupItem.title = newTitle;
                  controller.notifyListeners();
                },
                onPressed: (BuildContext context) {
                  context
                      .push(
                        KanBoardDetailScreen.routeName,
                        extra: card,
                      )
                      .then((_) => controller.notifyListeners());
                },
                allCards: allCards,
              ),
            );
          },
          boardScrollController: boardController,
          footerBuilder: (context, columnData) {
            return AppFlowyGroupFooter(
              icon: const Icon(Icons.add, size: 20),
              title: Text('New', style: Theme.of(context).textTheme.bodyMedium),
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
                width: columnData.headerData.groupName.length > 5 ? 90.w : 55.w,
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
              margin: config.groupBodyPadding,
            );
          },
          groupConstraints: BoxConstraints.tightFor(width: 0.9.sw),
          config: config,
        ),
      ),
    );
  }
}
