import 'package:flutter/material.dart';

class Account {
  String name;
  int money;
  Color? color = Colors.green;

  Account({
    this.color,
    required this.name,
    required this.money,
  });

// class AccountName {
//   String name;
//   AccountName({required this.name});
// }

// class AccountMoney {
//   int money;

//   AccountMoney({required this.money});

  void pickColor(Color? colorr) {
    color = colorr;
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
