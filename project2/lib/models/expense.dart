import 'package:flutter/material.dart';

class Expense {
  final Color color;
  final String name;
  final num amount;
  final IconData icon;
  Expense({
    this.color = Colors.blueAccent,
    required this.name,
    required this.amount,
    this.icon = Icons.store,
  });
}
