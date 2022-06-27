import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:project2/models/account.dart';

import 'history.dart';

class AccountData extends ChangeNotifier {
  List<String> accountsName = [
    'Mono',
    'Privat'
    // Account(name: 'Mono', money: '100'),
    // Account(name: 'Privat', money: '2000'),
    // Account(name: 'Cash', money: '50'),
  ];

  List<AccountMoney> accountsMoney = [
    AccountMoney(money: 100),
    AccountMoney(money: 2000),
  ];

  List<Record> records = [
    Record(name: 'Mono', amount: 100),
    Record(name: 'Privat', amount: 500),
  ];

  int? sumOfAccounts() {
    int sum = 0;
    for (int i = 0; i < accountsMoney.length.toInt(); i++) {
      sum += accountsMoney[i].money;
    }
    return sum;
  }

  void addAmountOnScreen(int amount, AccountMoney accountMoney, Record record) {
    accountMoney.addAmount(amount);
    records.insert(0, record);

    notifyListeners();
  }

  void minAmountOnScreen(int amount, AccountMoney accountMoney, Record record) {
    accountMoney.minAmount(amount);
    records.insert(0, record);
    record.action = true;

    notifyListeners();
  }

  void editAmountOnScreen(int newAmount, AccountMoney accountMoney) {
    accountMoney.editAmount(newAmount);
    notifyListeners();
  }

  void transferAmountOnScreen(
      int amount, AccountMoney accountMoney1, AccountMoney accountMoney2) {
    accountMoney1.transferAmount(accountMoney1, accountMoney2, amount);

    notifyListeners();
  }

  void addAccount(String accountName, AccountMoney accountsMoneyy) {
    accountsName.add(accountName);
    accountsMoney.add(accountsMoneyy);
    notifyListeners();
  }
}
