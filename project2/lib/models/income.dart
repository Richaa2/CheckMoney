import 'package:flutter/material.dart';

class Income {
  Color? color;
  String name;
  num amount;
  IconData? icon;
  int dateTime = DateTime.now().millisecondsSinceEpoch;
  Income({
    required this.dateTime,
    this.color = Colors.blueAccent,
    required this.name,
    required this.amount,
    this.icon = Icons.store,
  });

  void addIncome(int amount2) {
    amount = amount + amount2;
  }
}
