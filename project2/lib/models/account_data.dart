import 'package:flutter/cupertino.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/expense.dart';
import 'package:project2/models/income.dart';
// ignore: unused_import
import 'page_date.dart' as p;

import 'history.dart';

class AccountData extends ChangeNotifier {
  List<Account> accounts = [
    Account(name: 'Mono', money: 100),
    Account(name: 'Privat', money: 2000),
    Account(name: 'Cash', money: 50),
  ];
  List<Expense> expenses = [
    Expense(name: 'Market', amount: 100),
    Expense(name: 'Sport', amount: 1000),
    Expense(name: 'Hobby', amount: 2500),
    Expense(name: 'Dance', amount: 6666),
    Expense(name: 'Clouthes', amount: 500),
    Expense(name: 'Car', amount: 0),
    Expense(name: '', amount: 100),
    Expense(name: '', amount: 1000),
    Expense(name: '', amount: 2500),
    Expense(name: '', amount: 6666),
    Expense(name: '', amount: 500),
    Expense(name: '', amount: 500),
  ];

  List<Income> incomes = [
    Income(name: 'Job', amount: 100),
    Income(name: 'Dance', amount: 1000),
    Income(name: 'Gift', amount: 2500),
    Income(name: 'Binance', amount: 6666),
    Income(name: 'Crypto', amount: 500),
    Income(name: 'Futures', amount: 0),
    Income(name: '', amount: 100),
    Income(name: '', amount: 1000),
    Income(name: '', amount: 2500),
    Income(name: '', amount: 6666),
    Income(name: '', amount: 500),
    Income(name: '', amount: 500),
  ];
  Map<String, double> dataMapExpenses = {
    'Market': 100,
    'Sport': 1000,
    'Hobby': 2500,
    'Dance': 6666,
    'Clouthes': 500,
    'Car': 0,
  };

  Map<String, double> dataMapIncomes = {
    'Market': 100,
    'Sport': 1000,
    'Hobby': 2500,
    'Dance': 6666,
    'Clouthes': 500,
    'Car': 0,
  };
  List<Record> records = [
    Record(
        action: 2,
        name: 'Privat',
        amount: 1500,
        dateTime: DateTime.now().millisecondsSinceEpoch),
    Record(
        action: 2,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -19,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -19,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 1,
        name: 'Mono',
        amount: 1400,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -1,
            ))
            .millisecondsSinceEpoch)
  ]..sort((v1, v2) => v2.dateTime.compareTo(v1.dateTime));

  // List<p.Page> pages = List.generate(10, (index) {
  //   return p.Page(
  //       dateTime: DateTime.now()
  //           .add(Duration(
  //             days: Random().nextInt(1) + 10,
  //           ))
  //           .millisecondsSinceEpoch);
  // })
  //   ..sort((v1, v2) => v2.dateTime.compareTo(v1.dateTime));

  int? sumOfAccounts() {
    int sum = 0;
    for (int i = 0; i < accounts.length.toInt(); i++) {
      sum += accounts[i].money;
    }
    return sum;
  }

  double? sumOfExpenses() {
    double sum = 0;
    for (int i = 0; i < expenses.length.toInt(); i++) {
      sum += expenses[i].amount;
    }
    return sum;
  }

  void addAmountOnScreen(
      int amount, Account accountMoney, Record record, Income income) {
    accountMoney.addAmount(amount);
    records.insert(0, record);
    record.action = 2;
    income.addIncome(amount);

    notifyListeners();
  }

  void minAmountOnScreen(int amount, Account accountMoney, Record record) {
    accountMoney.minAmount(amount);
    records.insert(0, record);
    record.action = 1;

    notifyListeners();
  }

  void editAmountOnScreen(int newAmount, Account accountMoney) {
    accountMoney.editAmount(newAmount);
    notifyListeners();
  }

  void transferAmountOnScreen(
      int amount, Account accountMoney1, Account accountMoney2, Record record) {
    accountMoney1.transferAmount(accountMoney1, accountMoney2, amount);
    records.insert(0, record);
    record.action = 3;

    notifyListeners();
  }

  void addAccount(Account account) {
    accounts.add(account);
    notifyListeners();
  }
}
