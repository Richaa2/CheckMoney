import 'package:flutter/material.dart';

// class Account {
//   String name;
//   String money;

//   Account({
//     required this.name,
//     required this.money ,
//   });
// }

class AccountName {
  String name;
  AccountName({required this.name});
}

class AccountMoney {
  int money;

  AccountMoney({required this.money});

  void addAmount(int amount) {
    money = money + amount;
  }

  void minAmount(int amount) {
    money = money - amount;
  }

  void editAmount(int newAmount) {
    money = newAmount;
  }
}
