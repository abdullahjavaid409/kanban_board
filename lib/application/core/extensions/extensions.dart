import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtensionNum on num {
  String get twoDigits => toString().padLeft(2, "0");
}

extension ExtensionDuration on Duration {
  String get humanize =>
      "${inDays > 0 ? '${inDays}d ' : ''}${inHours.remainder(24).twoDigits}h:${inMinutes.remainder(60).twoDigits}m:${inSeconds.remainder(60).twoDigits}s";
}

extension StringExtension on String? {
  int toInt() => int.tryParse(this ?? "0") ?? 0;

  String compact() {
    final shadow = this;
    return shadow ?? "-";
  }

  double toFloat() => double.tryParse(this ?? "0.0") ?? 0.0;

  String capitalize() {
    final shadow = this;
    if (shadow != null && shadow.isNotEmpty) {
      return "${shadow[0].toUpperCase()}${shadow.substring(1).toLowerCase()}";
    }
    return "";
  }

  String defaultOnEmpty([String defaultValue = ""]) {
    final shadow = this;
    if (shadow == null || shadow.isEmpty) {
      return defaultValue;
    }
    return shadow;
  }
}

extension TimeSlots on String {
  /// Create time slot which depends on minutes

  List<BitSlot> timeSlots(
      {int? minutes, required DateTime startTime, required DateTime endTime}) {
    Duration step = Duration(minutes: minutes ?? 30);
    List<BitSlot> timeSlot = [];
    List<BitSlot> timeSlots = [
      BitSlot(
          startTime: startTime,
          endTime: startTime.add(Duration(minutes: minutes ?? 30)))
    ];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(BitSlot(
          startTime: timeIncrement,
          endTime: timeIncrement.add(Duration(minutes: minutes ?? 30))));
      startTime = timeIncrement;
    }
    timeSlots.forEach((e) {
      if (e.startTime.isBefore(endTime)) {
        return timeSlot.add(e);
      }
    });
    return timeSlot;
  }

  /// [7:30AM, 8:00AM, 8:30AM, 9:00AM, 9:30AM, 10:00AM, 10:30AM, 11:00AM, 11:30AM, 12:00PM, 12:30PM, 1:00PM, 1:30PM, 2:00 PM, 2:30 PM, 3:00 PM, 3:30 PM, 4:00 PM, 4:30 PM, 5:00 PM, 5:30 PM, 6:00 PM, 6:30 PM, 7:00 PM, 7:30 PM, 8:00 PM, 8:30 PM, 9:00 PM, 9:30 PM, 10:00 PM]

  String categoriesTimeStamp(String date) {
    DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    DateTime dt2 = DateTime.parse("2018-02-27 10:09:00");
    String greeting = "";
    final convertDate = date.convertFormattedTo24hr(date);

    final hours = DateTime.parse(convertDate).hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }

    return greeting;
  }

  String convertFormattedTo24hr(String timeString) {
    final DateFormat inputFormat = DateFormat("h:mm a");
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm');

    DateTime time = inputFormat
        .parse(timeString.toUpperCase()); // Convert to lowercase before parsing
    String formattedTime = outputFormat.format(time);

    return formattedTime;
  }

  String convertDateStringToString(String date) {
    ///2023-10-26T00:00:00.000Z to  oct, 23 2023
    final formattedTimes = DateTime.parse(date);
    final convertDate = DateFormat.yMMMd().format(formattedTimes);
    return convertDate;
  }
}

class BitSlot {
  String? date;
  String? id;
  final DateTime startTime;
  final DateTime endTime;
  bool isSelected;

  BitSlot(
      {required this.startTime,
      required this.endTime,
      this.isSelected = false,
      this.date,
      this.id});
}

extension DurationFormatting on Duration {
  String toHumanReadAble() {
    final shadow = this;

    /// 12:23:00
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String formattedDuration = shadow.inSeconds < 3600
        ? "${twoDigits(shadow.inMinutes.remainder(60))}:${twoDigits(shadow.inSeconds.remainder(60))}"
        : "${twoDigits(shadow.inHours)}:${twoDigits(shadow.inMinutes.remainder(60))}:${twoDigits(shadow.inSeconds.remainder(60))}";
    return formattedDuration;
  }
}

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    // assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    // assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();

  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool hasPixel() {
    final double pixelPk = MediaQuery.of(this).devicePixelRatio;
    return pixelPk > 2.0;
  }

  double pixel() {
    final double pixelPk = MediaQuery.of(this).devicePixelRatio;
    return pixelPk;
  }
}

extension ClickableExtension on Widget {
  Widget onTap(VoidCallback? action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }

  Widget inDevelopment() {
    return Banner(
        message: 'DEVELOPMENT',
        location: BannerLocation.topStart,
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 8),
        child: this);
  }

  Widget onWillPop(bool pop) {
    return WillPopScope(
        onWillPop: () async {
          return pop;
        },
        child: this);
  }
}

extension AddPadding on Widget {
  Widget addPadding(EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }
}

extension DateExtension on String {
  String get formattedDate =>
      DateFormat('yyyy-MM-dd').format(DateTime.parse(this));

  String get formattedTime => DateFormat.jm().format(DateTime.parse(this));

  String get americanFormattedDate =>
      DateFormat('MMM d,yyyy, h:mm a').format(DateTime.parse(this));
}

extension DateTimeExtension on DateTime {
  DateTime applyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day, hour, minute);

  DateTime applyTime(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute);

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime get dateOnly => DateTime(year, month, day);
  DateTime convertDateStringToDate(String date) {
    ///2023-10-26T00:00:00.000Z to  oct, 23 2023
    final formattedTimes = DateTime.parse(date);

    return formattedTimes;
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  List<DateTime> generateCurrentMonthDates() {
    DateTime now = DateTime.now(); // Get the current date and time
    DateTime firstDayOfMonth = DateTime(
        now.year, now.month, 1); // Get the first day of the current month
    DateTime lastDayOfMonth = DateTime(
        now.year, now.month + 1, 0); // Get the last day of the current month

    // Generate a list of all dates in the current month
    List<DateTime> dates = List.generate(
        lastDayOfMonth.day, (i) => firstDayOfMonth.add(Duration(days: i)));

    return dates;
  }

  List<DateTime> generateSelectedMonthDates({required int monthIndex}) {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonths = DateTime(now.year, now.month + 1, 0);
    int remainingMonthDays = lastDayOfMonths.day - now.day;
    // Get the current date and time
    DateTime firstDayOfMonth = DateTime(
        now.year, monthIndex, 1); // Get the first day of the current month
    DateTime lastDayOfMonth = DateTime(now.year, monthIndex + 1,
        now.month.toInt() == monthIndex ? remainingMonthDays + 1 : 0);
    // Generate a list of all dates in the current month
    List<DateTime> dates = List.generate(
        lastDayOfMonth.day, (i) => firstDayOfMonth.add(Duration(days: i)));

    return dates;
  }

  /// input start date and end date and get list of specific date day
  List<DateTime> getWeekdayDates(
      DateTime startDate, DateTime endDate, int targetWeekday) {
    List<DateTime> result = [];
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday == targetWeekday) {
        result.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return result;
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  int get weekOfYear {
    // Add 3 to always compare with January 4th, which is always in week 1
    // Add 7 to index weeks starting with 1 instead of 0
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  String format(String format) => DateFormat(format).format(this);

  DateTime findFirstDateOfTheWeek({DateTime? dateTime}) {
    dateTime ??= this;
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek({DateTime? dateTime}) {
    dateTime ??= this;
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String getMonthName(int monthNumber) {
    DateTime date = DateTime(year, monthNumber);
    return DateFormat.MMMM().format(date);
  }

  DateTime lastDayOfMonth() =>
      ((month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1))
          .subtract(const Duration(days: 1));
}
