import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    super.initState();
    descriptionController =
        TextEditingController(text: widget.card.description);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerProvider(widget.card));
    final timerNotifier = ref.read(timerProvider(widget.card).notifier);
    final comments = ref.watch(commentsProvider(widget.card));
    final commentsNotifier = ref.read(commentsProvider(widget.card).notifier);

    return Scaffold(
      appBar: AppBar(title: Text(widget.card.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KanBoardTextField(
              controller: descriptionController,
              hintText: 'Description',
              onChanged: (val) {
                if (val == null) return;
                ref.read(descriptionProvider(widget.card).notifier).state = val;
                widget.card.description = val;
              },
            ),
            const SizedBox(height: 10),
            Text("Tracked Time: ${formatDuration(timer)}"),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => timerNotifier.start(),
                  child: const Text("Start"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => timerNotifier.stop(),
                  child: const Text("Stop"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => timerNotifier.reset(),
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Comments"),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'Edit') {
                          _showEditCommentDialog(context, commentsNotifier,
                              index, comments[index]);
                        } else if (value == 'Delete') {
                          commentsNotifier.deleteComment(index);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextField(
              onSubmitted: (val) {
                commentsNotifier.addComment(val);
              },
              decoration: const InputDecoration(
                labelText: "Add a comment",
                border: OutlineInputBorder(),
              ),
            ),
          ],
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
