import 'package:flutter/material.dart';

import '../utils.dart';

class Income {
  String color = colorr.value.toString();
  String icon = icondataa!.codePoint.toString();
  String name;
  num amount;
  int dateTime = DateTime.now().millisecondsSinceEpoch;

  String id;

  Income({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.id,
    required this.color,
    required this.icon,
  });
  void addIncome(int amount2) {
    amount = amount + amount2;
  }
}
