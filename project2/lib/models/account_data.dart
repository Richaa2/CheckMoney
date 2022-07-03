import 'package:flutter/material.dart';
import 'package:project2/history_manager.dart';
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
    Expense(
      name: '1',
      amount: 0,
      color: Colors.teal,
      icon: Icons.store,
    ),
    Expense(
      name: '2',
      amount: 0,
      color: Colors.amber,
      icon: Icons.accessibility,
    ),
    Expense(
      name: '3',
      amount: 0,
      color: Colors.deepPurple,
      icon: Icons.add_alarm_sharp,
    ),
    Expense(
      name: '4',
      amount: 0,
      color: Colors.yellowAccent,
      icon: Icons.add_to_photos,
    ),
    Expense(
      name: '5',
      amount: 0,
      color: Colors.blue,
      icon: Icons.add_to_photos,
    ),
    Expense(
      name: '6',
      amount: 0,
      color: Colors.pink,
      icon: Icons.add_to_photos,
    ),
  ];

  List<Income> incomes = [
    Income(
      name: 'Job',
      amount: 0,
      color: Colors.pink,
      icon: Icons.add_to_photos,
    ),
    Income(
      name: 'Dance',
      amount: 0,
      color: Colors.blue,
      icon: Icons.add_to_photos,
    ),
    Income(
      name: 'Gift',
      amount: 0,
      color: Colors.yellowAccent,
      icon: Icons.add_to_photos,
    ),
    Income(
      name: 'Binance',
      amount: 0,
      color: Colors.blue,
      icon: Icons.add_to_photos,
    ),
    Income(
      name: 'Crypto',
      amount: 0,
      color: Colors.deepPurple,
      icon: Icons.add_alarm_sharp,
    ),
    Income(
      name: 'Futures',
      amount: 0,
      color: Colors.teal,
      icon: Icons.store,
    ),
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
              days: -30,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -50,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -130,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -100,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -200,
            ))
            .millisecondsSinceEpoch),
    Record(
        action: 3,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -250,
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

  void addExpense(
    Expense expense,
  ) {
    expenses.add(expense);

    notifyListeners();
  }

  void addIncome(
    Income income,
  ) {
    incomes.add(income);

    notifyListeners();
  }

  void Function()? buildListsWithEntries(List<Record> currentEntriess) {
    for (int i = 0; i < 4; i++) {
      currentEntriess = HistoryManager.manager.currentEntries(records, i);
    }
  }

  List<Record> currentEntries(
    List<Record> entries,
    int index,
  ) {
    bool isToday(DateTime date) {
      var today = DateTime.now();

      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        return true;
      }
      return false;
    }

    DateTime today = DateTime.now();

    // entries = Provider.of<AccountData>(context, listen: false).records;
    List<Record> currentEntries = [];
    if (index == 0) {
      currentEntries = entries
          .where((entry) =>
              isToday(DateTime.fromMillisecondsSinceEpoch(entry.dateTime)))
          .toList();
    } else if (index == 1) {
      Duration week = Duration(days: 7);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(week) <
              1)
          .toList();
    } else if (index == 2) {
      Duration month = Duration(days: 30);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(month) <
              1)
          .toList();
    } else if (index == 3) {
      Duration year = Duration(days: 365);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(year) <
              1)
          .toList();
    } else if (currentEntries.isEmpty) {
      currentEntries.add(Record(
          name: 'Test',
          amount: 1,
          dateTime: DateTime.now().millisecondsSinceEpoch));
    }

    currentEntries.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

    return currentEntries;
  }
}
