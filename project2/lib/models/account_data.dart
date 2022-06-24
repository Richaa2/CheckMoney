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

  List<int> accountsMoney = [100, 2500];

  int? sumOfAccounts() {
    int sum = 0;
    for (int i = 0; i < accountsMoney.length.toInt(); i++) {
      sum += accountsMoney[i];
    }
    return sum;
  }

  void addAmount(int amount, int index) {
    accountsMoney[index] + amount;
    print(accountsMoney[index]);
    notifyListeners();
  }

  void addAccount(String accountName, int accountsMoneyy) {
    accountsName.add(accountName);
    accountsMoney.add(accountsMoneyy);
    notifyListeners();
  }
}
