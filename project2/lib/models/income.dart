import 'package:flutter/material.dart';

class Income {
  Color? color;
  String name;
  num amount;
  int dateTime = DateTime.now().millisecondsSinceEpoch;

  IconData? icon;

  Income({
    required this.amount,
    required this.dateTime,
    this.color = Colors.blueAccent,
    required this.name,
    this.icon = Icons.store,
  });
  void addIncome(int amount2) {
    amount = amount + amount2;
  }
}
