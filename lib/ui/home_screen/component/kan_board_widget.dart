import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/constants.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/component/kanboard_dilaog.dart';
import 'package:kanban_board/ui/home_screen/provider/detail_provider.dart';
import 'package:kanban_board/widgets/common_widget.dart';

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
                      showEditCardDialog(context, cardModel, allCards, onEdit);
                    },
                    icon: Icon(Icons.edit, size: 15.h),
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
                  if (cardModel.timeSpent != 0)
                    IconTitleWidget(
                      title: _formatDuration(
                          Duration(seconds: cardModel.timeSpent)),
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
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds";
    } else if (duration.inMinutes > 0) {
      return "$minutes:$seconds";
    } else {
      return "$seconds s";
    }
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
