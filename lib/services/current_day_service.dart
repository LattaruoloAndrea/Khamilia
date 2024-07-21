import 'package:intl/intl.dart';

class CurrentDayService {
  DateTime currentDate() {
    return DateTime.now();
  }

  int currentDay() {
    return DateTime.now().day;
  }

  int currentMonth() {
    return DateTime.now().month;
  }

  int currentYear() {
    return DateTime.now().year;
  }

  DateTime getYesterdayDate(DateTime date) {
    return DateTime(date.year, date.month, date.day - 1);
  }

  DateTime getFromYesterdayTodayDate(DateTime date) {
    return DateTime(date.year, date.month, date.day - 1);
  }

  int getdateHalfDay(DateTime date) {
    var dayNoon = DateTime(date.year, date.month, date.day, 12);
    return dayNoon.millisecondsSinceEpoch;
  }

  int getdateStartDay(DateTime date) {
    var dayStart = DateTime(date.year, date.month, date.day);
    return dayStart.millisecondsSinceEpoch;
  }

  int getdateEndDay(DateTime date) {
    var dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return dayEnd.millisecondsSinceEpoch;
  }

  DateTime fromTimestapToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  String getDayOfTheWeek() {
    DateTime day = currentDate();
    String d = DateFormat('EEEE').format(day);
    return d.toLowerCase();
  }

  int getTimeForPeriodicService() {
    DateTime date = currentDate();
    var dayEnd = DateTime(date.year, date.month, date.day, 12, 11, 11);
    return dayEnd.millisecondsSinceEpoch;
  }

  DateTime fromString(String savedDateString) {
    savedDateString = savedDateString.replaceAll('/', '-');
    List<String> yMd = savedDateString.split('-');
    if (yMd.length == 3) {
      if (yMd[1].length == 1) {
        yMd[1] = "0${yMd[1]}";
      }
      if (yMd[2].length == 1) {
        yMd[2] = "0${yMd[2]}";
      }
    }
    DateTime tempDate = DateFormat("yyyy-dd-MM").parse(savedDateString);
    return tempDate;
  }

  String toStringDate(DateTime time) {
    String date = DateFormat("yyyy-dd-MM").format(time);
    return date;
  }
}
