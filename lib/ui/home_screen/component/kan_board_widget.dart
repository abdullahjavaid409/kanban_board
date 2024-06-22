import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';
import 'package:kanban_board/constant/constants.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_dilaog.dart';
import 'package:kanban_board/ui/home_screen/provider/detail_provider.dart';
import 'package:kanban_board/widgets/common_widget.dart';
import 'package:kanban_board/widgets/utils.dart';

class KanBoardCardWidget extends ConsumerWidget {
  final KanBoardCardModel cardModel;
  final BuildContextCallback onPressed;
  final Function(String) onEdit;
  final List<KanBoardCardModel> allCards;

  const KanBoardCardWidget({
    super.key,
    required this.cardModel,
    required this.onEdit,
    required this.onPressed,
    required this.allCards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(descriptionProvider(cardModel));
    final comments = ref.watch(commentsProvider(cardModel));
    final timer = ref.watch(timerProvider(cardModel));

    return KanBoardContainer(
      onPressed: onPressed,
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlack.withOpacity(0.1),
          spreadRadius: 0.7,
          offset: const Offset(0, 4),
        ),
      ],
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
                      ?.copyWith(fontWeight: FontWeight.w400),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: -4),
                onPressed: () {
                  showEditCardDialog(context, cardModel, allCards, onEdit);
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const VerticalSpacing(of: 5),
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const VerticalSpacing(of: 10),
          Row(
            children: [
              if (timer.inSeconds > 0)
                IconTitleWidget(
                  title: formatDuration(timer),
                ),
              const Spacer(),
              if (comments.isNotEmpty)
                IconTitleWidget(
                  icon: Icons.chat_bubble_outline,
                  title: '${comments.length}',
                ),
            ],
          ),
          const VerticalSpacing(of: 10),
        ],
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
