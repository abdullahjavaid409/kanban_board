import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours > 0) {
    return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
  } else if (minutes > 0) {
    return "${twoDigits(minutes)}:${twoDigits(seconds)}";
  } else {
    return "${twoDigits(seconds)}s";
  }
}

void displayToast(String? message) {
  if (message == null) return;

  Fluttertoast.showToast(
    webPosition: 'center',
    backgroundColor: AppColors.lightBlack,
    msg: message,
  );
}
