import 'package:flutter/cupertino.dart';
import 'package:project2/models/account.dart';

class AccountData extends ChangeNotifier {
  List<Account> accounts = [
    Account(name: 'Mono', money: '100'),
    Account(name: 'Privat', money: '2000'),
    Account(name: 'Cash', money: '50'),
  ];

  void sumOfAccounts() {}

  void addAccount(Account account) {
    accounts.add(Account(name: account.name, money: account.money));
    notifyListeners();
  }
}
