import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/expense.dart';
import 'package:project2/models/income.dart';

import 'user_info.dart' as q;

import 'history.dart';

class AccountData extends ChangeNotifier {
  List<Account> accounts = [];
  var userInput = '';

  void userInputs(String inputs) {
    userInput += inputs;

    notifyListeners();
  }

  void userDeleteInputs(bool allOrNot) {
    if (allOrNot == true) {
      userInput = '';
    }
    if (allOrNot == false && userInput != '') {
      userInput = userInput.substring(0, userInput.length - 1);
    }

    notifyListeners();
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    // if (userInput.contains(RegExp('.'))) {
    //   userInput = eval.toString();
    // } else {
    // userInput = eval.toInt().toString();
    // }
    userInput = eval.toInt().toString();
    if (userInput == '0') {
      userInput = '';
    }

    notifyListeners();
  }

  void ClearLists() {
    accounts.clear();
    records.clear();
    incomes.clear();
    expenses.clear();
  }

  // void getAccountStream() async {
  //   await for (var snapshot
  //       in FirebaseFirestore.instance.collection('account').snapshots()) {
  //     for (int i = 0; i < snapshot.docs.length; i++) {
  //       snapshot.docs[i].data();
  //       String color = snapshot.docs[i].data()['color'];
  //       String name = snapshot.docs[i].data()['name'];
  //       num money = snapshot.docs[i].data()['money'];
  //       String icon = snapshot.docs[i].data()['icon'];
  //       String id;
  //       int q = snapshot.docs[i].data()['q'];
  //       if (snapshot.docs[i].data()['id'] != null) {
  //         id = snapshot.docs[i].data()['id'];
  //       } else {
  //         id = 'nothing';
  //       }
  //       accounts.add(Account(
  //           colorValue: color,
  //           name: name,
  //           money: money.toInt(),
  //           icon: icon,
  //           id: id,
  //           q: q));
  //     }
  //     notifyListeners();
  //   }
  // }

  void addAccountFirebase(Account account) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .add({
      "name": account.name,
      "color": account.colorValue,
      "id": account.id,
      "icon": account.icon,
      "money": account.money,
      "q": account.q
    });

    // FirebaseFirestore.instance.collection("account").add({});

    // .then((value) {
    //   accounts.add(Account(
    //       name: account.name,
    //       colorValue: account.colorValue,
    //       icon: account.icon,
    //       id: account.id,
    //       money: account.money,
    //       q: account.q));
    // });
    notifyListeners();
  }

  void removeIncomeExpense(
      bool inOrEx, AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var id = snapshot.data!.docs[index].id;

    if (incomes.length > 1 || inOrEx == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('income')
          .doc(id)
          .delete();
      incomes.removeAt(index);
      print('Income');
    }

    if (expenses.length > 1 || inOrEx == false) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('expense')
          .doc(id)
          .delete();
      expenses.removeAt(index);
      print('Expense');
    }
  }

  void removeEx(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var id = snapshot.data!.docs[index].id;

    if (expenses.length > 1) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('expense')
          .doc(id)
          .delete();
      expenses.removeAt(index);
    }
    if (expenses.length == 1) {}
  }

  void removeAccount(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var id = snapshot.data!.docs[index].id;

    if (accounts.length > 1) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('account')
          .doc(id)
          .delete();
      accounts.removeAt(index);
    }
    if (accounts.length == 1) {}
  }

  void removeRecord(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var id = snapshot.data!.docs[index].id;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('record')
        .doc(id)
        .delete();

    records.removeAt(index);

    notifyListeners();
  }

  List<Expense> expenses = [];

  List<Income> incomes = [];

  List<Record> records = []
    ..sort((v1, v2) => v2.dateTime.compareTo(v1.dateTime));

  q.UserInfo sumUser = q.UserInfo(amount: 0, name: '', email: '');

  int? sumOfAccounts(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
  ) {
    var sum = 0;

    if (accounts.isEmpty) {
      print('HELLO');
    }
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('account')
    //     .get()
    //     .whenComplete(() {
    //   for (int i = 0; i < accounts.length; i++) {
    //     final data = {
    //       'money': accounts[i].money,
    //     };
    //     data.forEach((key, value) {
    //       sum += value;
    //     });
    //   }
    // });
    if (accounts.isNotEmpty) {
      for (int i = 0; i < accounts.length; i++) {
        // final data = {
        //   'money': accounts[i].money,
        // };
        // data.forEach((key, value) {
        //   sum += value;
        // });

        sum += accounts[i].money;
      }
    }

    print(sum);
    // sumUser.amount = sum;

    return sum;
  }

  void regUser(
    String email,
  ) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userInfo')
        .add({
      "name": 'name',
      "sum": 0,
      "email": email,
    });

    notifyListeners();
  }

  void updateNameOfAccount(
    String newName,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    q.UserInfo userInfo,
  ) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userInfo.updateName(newName);

    var id = snapshot.data!.docs[0].id;
    print(id);
// FirebaseFirestore.instance.collection('users').doc(uid).collection('userInfo').doc(id).se

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userInfo')
        .doc(id)
        .update({
      'name': userInfo.name,
    });

    notifyListeners();
  }

  int? updateSum(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
  ) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    int? suma = sumOfAccounts(snapshot);

    var id = snapshot.data!.docs[0].id;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userInfo')
        .doc(id)
        .update({
      'sum': suma,
    });

    return suma;
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
    int amount,
    // Account accountMoney,
    Record record,
    // Income income,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    int index,
    int index2,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot2,
    q.UserInfo userInfo,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshotInfo,
  ) {
    // sumUser.plusSum(amount);
    Account accountMoney = accounts[index];
    Income income = incomes[index2];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    records.insert(0, record);
    record.action = 2;
    accountMoney.addAmount(amount);
    income.addIncome(amount);
    userInfo.plusSum(amount);
    var id = snapshot2.data!.docs[index].id;
    var id2 = snapshot.data!.docs[index2].id;
    var idInfo = snapshotInfo.data!.docs[0].id;
    final data = {
      'money': accountMoney.money,
      'color': accountMoney.colorValue,
      'icon': accountMoney.icon,
      'name': accountMoney.name,
      'id': accountMoney.id,
      'q': accountMoney.q,
    };

    final dataIncome = {
      'amount': income.amount,
      'color': income.color,
      'name': income.name,
      'dateTime': income.dateTime,
      'icon': income.icon,
      'id': income.id,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .doc(id)
        .set(data);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('record')
        .add({
      "name": record.name,
      "id": record.id,
      "amount": record.amount,
      "action": record.action,
      'dateTime': record.dateTime,
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('income')
        .doc(id2)
        .set(dataIncome);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userInfo')
        .doc(idInfo)
        .update({'sum': userInfo.amount});

    notifyListeners();
  }

  void minAmountOnScreen(
    int amount,
    Account accountMoney,
    Record record,
    Expense expense,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    int index,
    int index2,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot2,
  ) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    accountMoney.minAmount(amount);
    records.insert(0, record);
    record.action = 1;
    expense.addExpense(amount);
    var id = snapshot2.data!.docs[index].id;
    var id2 = snapshot.data!.docs[index2].id;
    final data = {
      'money': accountMoney.money,
      'color': accountMoney.colorValue,
      'icon': accountMoney.icon,
      'name': accountMoney.name,
      'id': accountMoney.id,
      'q': accountMoney.q,
    };

    final dataExpense = {
      'amount': expense.amount,
      'color': expense.color,
      'name': expense.name,
      'dateTime': expense.dateTime,
      'icon': expense.icon,
      'id': expense.id,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .doc(id)
        .set(data);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('record')
        .add({
      "name": record.name,
      "id": record.id,
      "amount": record.amount,
      "action": record.action,
      'dateTime': record.dateTime,
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expense')
        .doc(id2)
        .set(dataExpense);

    notifyListeners();
  }

  void editAmountOnScreen(int newAmount, Account accountMoney,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    accountMoney.editAmount(newAmount);
    var id = snapshot.data!.docs[index].id;
    final data = {
      'money': accountMoney.money,
      'color': accountMoney.colorValue,
      'icon': accountMoney.icon,
      'name': accountMoney.name,
      'id': accountMoney.id,
      'q': accountMoney.q,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .doc(id)
        .set(data);
    notifyListeners();
  }

  void transferAmountOnScreen(
      int amount,
      Account accountMoney1,
      Account accountMoney2,
      Record record,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index1,
      int index2) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    accountMoney1.transferAmount(accountMoney1, accountMoney2, amount);
    records.insert(0, record);
    record.action = 3;
    var id1 = snapshot.data!.docs[index1].id;
    var id2 = snapshot.data!.docs[index2].id;
    final data1 = {
      'money': accountMoney1.money,
      'color': accountMoney1.colorValue,
      'icon': accountMoney1.icon,
      'name': accountMoney1.name,
      'id': accountMoney1.id,
      'q': accountMoney1.q,
    };
    final data2 = {
      'money': accountMoney2.money,
      'color': accountMoney2.colorValue,
      'icon': accountMoney2.icon,
      'name': accountMoney2.name,
      'id': accountMoney2.id,
      'q': accountMoney2.q,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .doc(id1)
        .set(data1);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('account')
        .doc(id2)
        .set(data2);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('record')
        .add({
      "name": record.name,
      "id": record.id,
      "amount": record.amount,
      "action": record.action,
      'dateTime': record.dateTime,
    });

    notifyListeners();
  }

  void addAccount(
    Account account,
  ) {
    accounts.add(account);
    // account.pickColor(color);
    // account.pickIcon(icon);

    notifyListeners();
  }

  void addExpense(Expense expense) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("expense")
        .add({
      "name": expense.name,
      "color": expense.color,
      "id": expense.id,
      "icon": expense.icon,
      "amount": expense.amount,
      "dateTime": expense.dateTime
    });

    expenses.add(expense);

    notifyListeners();
  }

  void addIncome(Income income) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("income")
        .add({
      "name": income.name,
      "color": income.color,
      "id": income.id,
      "icon": income.icon,
      "amount": income.amount,
      "dateTime": income.dateTime
    });

    incomes.add(income);

    notifyListeners();
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
    }

    currentEntries.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

    return currentEntries;
  }
}
