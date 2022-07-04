import 'package:flutter/material.dart';

class Expense {
  Color? color;
  String name;
  num amount;
  IconData? icon;
  DateTime? dateTime;
  Expense({
    this.dateTime,
    this.color = Colors.blueAccent,
    required this.name,
    required this.amount,
    this.icon = Icons.store,
  });

  void addExpense(int amount2) {
    amount = amount + amount2;
  }
}
