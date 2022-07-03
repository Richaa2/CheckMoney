import 'package:project2/models/history.dart';

class HistoryManager {
  static final manager = HistoryManager();

  bool isToday(DateTime date) {
    var today = DateTime.now();

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return true;
    }
    return false;
  }

  List<Record> currentEntries(List<Record> entries, int index) {
    DateTime today = DateTime.now();

    List<Record> currentEntries = [];
    if (index == 0) {
      currentEntries = entries
          .where((entry) =>
              isToday(DateTime.fromMillisecondsSinceEpoch(entry.dateTime)))
          .toList();
    } else if (index == 1) {
      Duration week = Duration(days: 7);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(week) <
              1)
          .toList();
    } else if (index == 2) {
      Duration month = Duration(days: 30);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(month) <
              1)
          .toList();
    } else if (index == 3) {
      Duration year = Duration(days: 365);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(year) <
              1)
          .toList();
    }

    currentEntries.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

    return currentEntries;
  }
}
