import 'package:flutter/material.dart';

class Income {
  Color? color;
  String name;

  IconData? icon;

  Income({
    this.color = Colors.blueAccent,
    required this.name,
    this.icon = Icons.store,
  });
}

class IncomeAmount {
  num amount;
  int dateTime = DateTime.now().millisecondsSinceEpoch;
  IncomeAmount({
    required this.amount,
    required this.dateTime,
  });

  void addIncome(int amount2) {
    amount = amount + amount2;
  }
}
