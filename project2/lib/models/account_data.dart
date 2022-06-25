import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:project2/models/account.dart';

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

  int? sumOfAccounts() {
    int sum = 0;
    for (int i = 0; i < accountsMoney.length.toInt(); i++) {
      sum += accountsMoney[i].money;
    }
    return sum;
  }

  // int addAmount(int amount, int index) {
  //   int el = accountsMoney.elementAt(index);
  //   int sum = el += amount;
  //   return sum;
  // }

  // int? addAmount(int amount, int main, int index) {
  //   int sum = amount + main;
  //   notifyListeners();
  //   return sum;
  // }

  void addAmountOnScreen(int amount, AccountMoney accountMoney) {
    accountMoney.addAmount(amount);
    notifyListeners();
  }

  void minAmountOnScreen(int amount, AccountMoney accountMoney) {
    accountMoney.minAmount(amount);
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
