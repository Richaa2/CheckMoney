import 'package:flutter/material.dart';

class Income {
  final Color color;
  final String name;
  final num amount;
  final IconData icon;
  Income({
    this.color = Colors.blueAccent,
    required this.name,
    required this.amount,
    this.icon = Icons.store,
  });
}
