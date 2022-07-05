import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      colorValue: Colors.amber.value.toString(),
      icon: Icons.credit_card.codePoint.toString(),
    ),
    Account(
        name: 'Privat',
        money: 2000,
        colorValue: Colors.blueAccent.value.toString(),
        icon: Icons.credit_card.codePoint.toString()),
    Account(
      name: 'Cash',
      money: 50,
      colorValue: Colors.teal.value.toString(),
      icon: Icons.credit_card.codePoint.toString(),
    )
  ];

  late FirebaseAuth auth;
  User? user; //null if not signed in
  AppProvider() {
    auth = FirebaseAuth.instance;
    setupAuthListener();
  }

  Future<UserCredential> signIn() {
    return auth.signInAnonymously();
  }

  setupAuthListener() {
    auth.authStateChanges().listen((user) {
      print("is user signed in: ${user != null} as ${user?.uid}");
      this.user = user;
      if (user != null) {
        load();
      }
    });
  }

  load() async {
    late QuerySnapshot query;
    QueryDocumentSnapshot? lastLoaded;
    late bool loading = false;
    late bool endReached = false;
    if (user == null || endReached || loading) return;
    loading = true;

    if (lastLoaded == null) {
      accounts.clear();
    }
    Query q = FirebaseFirestore.instance
        .collection("account")
        .where("id", isEqualTo: user?.uid)
        .orderBy("name");

    if (lastLoaded != null) {
      print("Loading more: ${accounts.length}");
      q = q.startAfterDocument(lastLoaded);
    }

    query = await q.limit(5).get();

    if (query.docs.length != 5) {
      bool endReached = true;
    }
    //  lastLoaded = query.docs.last;
    // query.docs.forEach((element) {
    //   accounts.add(Account.fromMap(element.data(), element.id));
    // });
    loading = false;
    notifyListeners();
  }

  void addAccountFirebase(String title, String color, String icon, int money) {
    FirebaseFirestore.instance.collection("account").add({
      "name": title,
      "color": color,
      "id": user!.uid,
      "icon": icon,
    }).then((value) {
      accounts.add(Account(
          name: title,
          colorValue: color,
          icon: icon,
          id: value.id,
          money: money));
      notifyListeners();
    });
  }

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
      dateTime: DateTime.now().millisecondsSinceEpoch,
    ),
    Income(
      name: 'Dance',
      amount: 1,
      color: Colors.blue,
      icon: Icons.add_to_photos,
      dateTime: DateTime.now()
          .add(const Duration(
            days: -1,
          ))
          .millisecondsSinceEpoch,
    ),
    Income(
      name: 'Gift',
      amount: 5,
      color: Colors.yellowAccent,
      icon: Icons.add_to_photos,
      dateTime: DateTime.now()
          .add(const Duration(
            days: -5,
          ))
          .millisecondsSinceEpoch,
    ),
    Income(
      name: 'Binance',
      amount: 10,
      color: Colors.blue,
      icon: Icons.add_to_photos,
      dateTime: DateTime.now()
          .add(const Duration(
            days: -10,
          ))
          .millisecondsSinceEpoch,
    ),
    Income(
      name: 'Crypto',
      amount: 35,
      color: Colors.deepPurple,
      icon: Icons.add_alarm_sharp,
      dateTime: DateTime.now()
          .add(const Duration(
            days: -35,
          ))
          .millisecondsSinceEpoch,
    ),
    Income(
      name: 'Futures',
      amount: 150,
      color: Colors.teal,
      icon: Icons.store,
      dateTime: DateTime.now()
          .add(const Duration(
            days: -150,
          ))
          .millisecondsSinceEpoch,
    ),
  ];

  List<Record> records = [
    Record(
        action: 2,
        name: 'Privat',
        amount: 1500,
        dateTime: DateTime.now().millisecondsSinceEpoch),
    Record(
        action: 2,
        name: 'Privat',
        amount: 1300,
        dateTime: DateTime.now().millisecondsSinceEpoch),
    Record(
        action: 2,
        name: 'Mono',
        amount: 1000,
        dateTime: DateTime.now()
            .add(const Duration(
              days: -5,
            ))
            .millisecondsSinceEpoch),
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
  ]..sort((v1, v2) => v2.dateTime.compareTo(v1.dateTime));

  int? sumOfAccounts() {
    int sum = 0;
    for (int i = 0; i < accounts.length.toInt(); i++) {
      sum += accounts[i].money;
    }
    return sum;
  }

  int? sumOfRecords(int index) {
    int sum = 0;
    for (int i = 0; i < currentEntries(records, index).length; i++) {
      if (currentEntries(records, index)[i].action == 1) {
        return sum -= currentEntries(records, index)[i].amount.toInt();
      }
      sum += currentEntries(records, index)[i].amount.toInt();
      if (currentEntries(records, index)[i].action == 3) {
        sum -= currentEntries(records, index)[i].amount.toInt();
      }
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

  // double? sumOfDay(List<Record> entries) {
  //   bool isToday(DateTime date) {
  //     var today = DateTime.now();

  //     if (date.year == today.year &&
  //         date.month == today.month &&
  //         date.day == today.day) {
  //       return true;
  //     }
  //     return false;
  //   }

  //   int index = 0;
  //   double sum = 0;

  //   if (records ==
  //       entries
  //           .where((entry) =>
  //               isToday(DateTime.fromMillisecondsSinceEpoch(entry.dateTime)))
  //           .toList()) {
  //     while (records[index].dateTime == records[index + 1].dateTime) {
  //       sum += records[index].amount.toDouble();
  //       index++;
  //     }
  //     return sum;
  //   }

  //   return sum;
  // }

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
