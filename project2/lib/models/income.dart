import 'package:flutter/material.dart';

class Income {
  final Color color;
  final String name;
  num amount;
  final IconData icon;
  Income({
    this.color = Colors.blueAccent,
    required this.name,
    required this.amount,
    this.icon = Icons.store,
  });

  void addIncome(int amount2) {
    amount = amount + amount2;
  }
}
