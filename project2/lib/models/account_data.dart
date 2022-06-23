import 'package:flutter/cupertino.dart';
import 'package:project2/models/account.dart';

class AccountData extends ChangeNotifier {
  List<String> accountsName = [
    'Mono'
    // Account(name: 'Mono', money: '100'),
    // Account(name: 'Privat', money: '2000'),
    // Account(name: 'Cash', money: '50'),
  ];

  List<String> accountsMoney = ['100'];

  void sumOfAccounts() {}

  void addAccount(String accountName, String accountsMoneyy) {
    accountsName.add(accountName);
    accountsMoney.add(accountsMoneyy);
    notifyListeners();
  }
}
