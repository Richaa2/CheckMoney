import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';

import 'package:project2/screen/add_account/add_account_screen.dart';
import 'package:project2/screen/add_ex_in/add_expense.dart';
import 'package:project2/screen/add_ex_in/add_income.dart';
import 'package:project2/screen/history_screen.dart';

import 'package:provider/provider.dart';

import 'screen/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountData>(
      create: (BuildContext context) => AccountData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/addAcc': (context) => const AddAccountScreen(),
          '/addExp': ((context) => const AddExpenseScreen()),
          '/addInc': ((context) => const AddIncomeScreen()),
        },
        title: 'Project',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
