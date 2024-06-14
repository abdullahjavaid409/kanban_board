import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';

class KanBoardDetailScreen extends StatelessWidget {
  static const String routeName = '/KanBoardDetailScreen';
  const KanBoardDetailScreen({super.key, required this.item});
  final AppFlowyGroupItem? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item?.id ?? '')),
    );
  }
}
