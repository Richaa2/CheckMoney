import 'package:flutter/material.dart';

Color colorr = Colors.green;
IconData? icondataa = IconData(0xe737, fontFamily: 'MaterialIcons');

class Account {
  late String name;
  late int money;
  String colorValue = colorr.value.toString();
  String icon = icondataa!.codePoint.toString();
  String? id;

  Account(
      {required this.colorValue,
      required this.name,
      required this.money,
      required this.icon,
      this.id});

  Account.fromMap(Map<String, dynamic> data, this.id) {
    this.name = data['name'];
    this.money = data['money'];
    this.colorValue = data['color'];
    this.icon = data['icon'];
  }

  void pickIcon(IconData? iconn) {
    icon = iconn.toString();
  }

  void pickColor(Color? colorr) {
    colorValue = colorr.toString();
  }

  void addAmount(int amount) {
    money = money + amount;
  }

  void minAmount(int amount) {
    money = money - amount;
  }

  void editAmount(int newAmount) {
    money = newAmount;
  }

  void transferAmount(
      Account accountMoney1, Account accountMoney2, int amount) {
    accountMoney1.money = accountMoney1.money - amount;
    accountMoney2.money = accountMoney2.money + amount;
  }
}
