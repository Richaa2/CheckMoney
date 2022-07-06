import 'package:flutter/material.dart';

Color colorr = Colors.green;
IconData? icondataa = IconData(0xe737, fontFamily: 'MaterialIcons');

class AccountFirebase {
  late String name;
  late int money;
  String colorValue = colorr.value.toString();
  String icon = icondataa!.codePoint.toString();
  String id;

  AccountFirebase(
      {required this.colorValue,
      required this.name,
      required this.money,
      required this.icon,
      required this.id});

  AccountFirebase.fromMap(Map<String, dynamic> data, this.id) {
    name = data['name'];
    money = data['money'];
    colorValue = data['color'];
    icon = data['icon'];
  }
}
