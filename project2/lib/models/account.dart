import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class Account {
  late String name;
  late int money;
  String colorValue = colorr.value.toString();
  String icon = icondataa.codePoint.toString();
  String id;
  int q = 1;

  Account(
      {required this.colorValue,
      required this.name,
      required this.money,
      required this.icon,
      required this.id,
      required this.q});

  Account.fromMap(Map<String, dynamic> data, this.id) {
    name = data['name'];
    money = data['money'];
    colorValue = data['color'];
    icon = data['icon'];
    q = data['q'];
  }

  factory Account.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Account(
      name: data?['name'],
      money: data?['money'],
      colorValue: data?['color'],
      icon: data?['icon'],
      q: data?['q'],
      id: data?['id'],
    );
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
