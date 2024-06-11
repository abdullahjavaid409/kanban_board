import 'package:flutter/material.dart';

extension SizeExt on double {
  SizedBox verticalBoxPadding() => SizedBox(height: this);

  SizedBox horizontalBoxPadding() => SizedBox(width: this);
}

typedef BuildContextCallback = void Function(BuildContext context);

class Constants {
  static const notAvailable = 'N/A';

  static String? months(int value) {
    switch (value) {
      case 1:
        return "JANUARY";
      case 2:
        return "FEBRUARY";
      case 3:
        return "MARCH";
      case 4:
        return "APRIL";
      case 5:
        return "MAY";
      case 6:
        return "JUNE";
      case 7:
        return "JULY";
      case 8:
        return "AUGUST";
      case 9:
        return "SEPTEMBER";
      case 10:
        return "OCTOBER";
      case 11:
        return "NOVEMBER";
      case 12:
        return "DECEMBER";
      default:
        return null;
    }
  }

  static int? weekDay(String value) {
    switch (value) {
      case 'Mon':
        return 0;
      case 'Tue':
        return 1;
      case 'Wed':
        return 2;
      case 'Thu':
        return 3;
      case 'Fri':
        return 4;
      case 'Sat':
        return 5;
      case 'Sun':
        return 6;
      default:
        return 0;
    }
  }

  static List<int> daysInMonthList = [
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  static const apiDateFormat = "dd-MM-yyyy";
  static const dateMonthYearFormat = "d MMMM, yy";
  static const monYearFormat = "MMM yy";
  static const dateMonthFormat = "MMM d";
  static const dateWeetDateFormat = "EEE d";

  ///2023 July 10 AD 12:08 PM
  static const completeDateTime = "yyyy MMM dd hh:mm aaa";

  ///Wed, 11 Jan , 2023
  static const weekDateMonYear = "EEE, d MMM , yyyy";

  /// 11 Wed
  static const dateDay = "d EEE";

  ///wed
  static const day = "EEE";

  //02
  static const date = "dd";
}
