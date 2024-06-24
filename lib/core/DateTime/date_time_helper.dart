import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getHoursByAmBm(DateTime dateTime) {
    var format = DateFormat.jm();
    var dateString = format.format(DateTime.now());
    return dateString;
  }

  static String getDatetimeFormat2(DateTime dateTime) {
    var format = DateFormat.yMMMMd('en');
    String dateString = format.format(dateTime);
    String newDate = dateString.replaceAll('/', '-');
    return newDate;
  }

  static String formatt(timeStamp) {
    var times = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('yMMMd').format(times);
  }

  static String formatt2(timeStamp) {
    var times = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('jm').format(times);
  }

  static String getDatetimeFormat(DateTime dateTime) {
    var format = DateFormat.yMMMEd();
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String getDatetimeFormatmonth(DateTime dateTime) {
    var format = DateFormat.M();
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String getHours(DateTime dateTime) {
    String ss = DateFormat('h:mm a').format(dateTime);

    return ss;
  }

  static String getDayByWeekDay(
      {required BuildContext context, required int weekday}) {
    if (weekday == 1) {
      return 'الاثنين';
    } else if (weekday == 2) {
      return 'الثلاثاء';
    } else if (weekday == 3) {
      return 'الاربعاء';
    } else if (weekday == 4) {
      return 'الخميس';
    } else if (weekday == 5) {
      return 'الجمعه';
    } else if (weekday == 6) {
      return 'السبت';
    } else {
      return 'الاحد';
    }
  }

  static String getMonth(String month) {
    switch (month) {
      case '1':
        return 'يناير';
      case '2':
        return 'فبراير';
      case '3':
        return 'مارس';
      case '4':
        return 'ابريل';
      case '5':
        return 'مايو';
      case '6':
        return 'يونيو';
      case '7':
        return 'يوليو';
      case '8':
        return 'اغسطس';
      case '9':
        return 'سبتمبر';
      case '10':
        return 'اكتوبر';
      case '11':
        return 'نوفمبر';
      case '12':
        return 'ديسمبر';
      default:
        return '..';
    }
  }
}
