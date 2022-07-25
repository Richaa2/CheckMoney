import '../utils.dart';

class Expense {
  String color = colorr.value.toString();
  String icon = icondataa.codePoint.toString();
  String name;
  num amount;
  int? dateTime;
  String id;

  Expense({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.id,
    required this.color,
    required this.icon,
  });

  void addExpense(int amount2) {
    amount = amount + amount2;
  }
}
