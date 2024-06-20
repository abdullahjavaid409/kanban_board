import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/data/models/kan_board_card_model.dart';
import 'package:kanban_board/widgets/utils.dart';

import '../provider/detail_provider.dart';

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
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              onChanged: (val) {
                ref
                    .read(descriptionProvider(widget.card).notifier)
                    .updateDescription(val);
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
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]),
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
}
