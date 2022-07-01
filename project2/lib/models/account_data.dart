import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/expense.dart';
import 'package:project2/models/income.dart';
// ignore: unused_import
import 'page_date.dart' as p;

import 'history.dart';

class AccountData extends ChangeNotifier {
  List<Account> accounts = [
    Account(
      name: 'Mono',
      money: 100,
      color: Colors.amber,
      icon: Icons.credit_card,
    ),
    Account(
        name: 'Privat',
        money: 2000,
        color: Colors.blueAccent,
        icon: Icons.credit_card),
    Account(
      name: 'Cash',
      money: 50,
      color: Colors.teal,
      icon: Icons.credit_card,
    )
  ];
  List<Expense> expenses = [
    Expense(name: 'Market', amount: 0),
    Expense(name: 'Sport', amount: 0),
    Expense(name: 'Hobby', amount: 0),
    Expense(name: 'Dance', amount: 0),
    Expense(name: 'Clouthes', amount: 0),
    Expense(name: 'Car', amount: 0),
    Expense(name: '', amount: 0),
    Expense(name: '', amount: 0),
    Expense(name: '', amount: 0),
    Expense(name: '', amount: 0),
    Expense(name: '', amount: 0),
    Expense(name: '', amount: 0),
  ];

  List<Income> incomes = [
    Income(name: 'Job', amount: 0),
    Income(name: 'Dance', amount: 0),
    Income(name: 'Gift', amount: 0),
    Income(name: 'Binance', amount: 0),
    Income(name: 'Crypto', amount: 0),
    Income(name: 'Futures', amount: 0),
    Income(name: '', amount: 0),
    Income(name: '', amount: 0),
    Income(name: '', amount: 0),
    Income(name: '', amount: 0),
    Income(name: '', amount: 0),
    Income(name: '', amount: 0),
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

  double? sumOfIncomes() {
    double sum = 0;
    for (int i = 0; i < incomes.length.toInt(); i++) {
      sum += incomes[i].amount;
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

  void minAmountOnScreen(
      int amount, Account accountMoney, Record record, Expense expense) {
    accountMoney.minAmount(amount);
    records.insert(0, record);
    record.action = 1;
    expense.addExpense(amount);

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

  void addAccount(Account account, Color? color, IconData? icon) {
    accounts.add(account);
    account.pickColor(color);
    account.pickIcon(icon);

    notifyListeners();
  }
}
