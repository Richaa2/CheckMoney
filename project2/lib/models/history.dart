import '../utils.dart';

class Record {
  String name;
  num amount;
  int action;
  int dateTime;
  String id;
  String color = colorr.value.toString();
  String icon = icondataa.codePoint.toString();
  String subName;
  String icon2 = icondataa.codePoint.toString();
  Record({
    required this.name,
    required this.amount,
    this.action = 1,
    required this.dateTime,
    this.id = '5',
    required this.icon,
    required this.color,
    required this.subName,
    required this.icon2,
  });
}
