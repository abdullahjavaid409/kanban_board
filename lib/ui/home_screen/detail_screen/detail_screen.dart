import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/ui/home_screen/provider/detail_provider.dart';
import 'package:kanban_board/widgets/common_widget.dart';
import 'package:kanban_board/widgets/utils.dart';

class KanBoardDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = '/KanBoardDetailScreen';
  final KanBoardCardModel card;

  const KanBoardDetailScreen({super.key, required this.card});

  @override
  ConsumerState<KanBoardDetailScreen> createState() =>
      _KanBoardDetailScreenState();
}

class _KanBoardDetailScreenState extends ConsumerState<KanBoardDetailScreen> {
  late TextEditingController descriptionController;
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    descriptionController =
        TextEditingController(text: widget.card.description);
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerProvider(widget.card));
    final timerNotifier = ref.read(timerProvider(widget.card).notifier);
    final comments = ref.watch(commentsProvider(widget.card));
    final commentsNotifier = ref.read(commentsProvider(widget.card).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.title,
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KanBoardTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 10,
                  onChanged: (val) {
                    if (val == null) return;
                    ref.read(descriptionProvider(widget.card).notifier).state =
                        val;
                    widget.card.description = val;
                  },
                ),
                const VerticalSpacing(of: 10),
                Text("Tracked Time: ${formatDuration(timer)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
                const VerticalSpacing(of: 10),
                Row(
                  children: [
                    Expanded(
                        child: KanBoardElevatedButton(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                            color: AppColors.greenAccent,
                            onTap: (_) => timerNotifier.start(),
                            title: 'Start')),
                    const HorizontalSpacing(of: 10),
                    Expanded(
                        child: KanBoardElevatedButton(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                            color: AppColors.redAccent,
                            onTap: (_) => timerNotifier.stop(),
                            title: 'Stop')),
                    const SizedBox(width: 10),
                    Expanded(
                        child: KanBoardElevatedButton(
                            color: AppColors.backgroundColor.withOpacity(0.9),
                            onTap: (_) => timerNotifier.reset(),
                            title: 'Reset')),
                  ],
                ),
                const VerticalSpacing(),
                Text("Comments",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
                const VerticalSpacing(of: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 20.w),
                          title: Text(comments[index],
                              style: Theme.of(context).textTheme.bodyMedium),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'Edit') {
                                _showEditCommentDialog(context,
                                    commentsNotifier, index, comments[index]);
                              } else if (value == 'Delete') {
                                commentsNotifier.deleteComment(index);
                                displayToast("Successfully Delete comment");
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'Delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                KanBoardTextField(
                  controller: commentController,
                  hintText: 'Add a comment',
                  onFieldSubmitted: (val) {
                    if (val == null || val.isEmpty) return;
                    commentsNotifier.addComment(val);
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditCommentDialog(BuildContext context,
      CommentsNotifier commentsNotifier, int index, String currentComment) {
    final TextEditingController commentController =
        TextEditingController(text: currentComment);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              labelText: 'Comment',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                commentsNotifier.updateComment(index, commentController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
