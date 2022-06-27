import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';

import 'package:project2/screen/add_account_screen.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:provider/provider.dart';

import 'screen/main_page.dart';
import 'screen/select_account_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountData>(
      create: (BuildContext context) => AccountData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/addAcc': (context) => AddAccountScreen(),
        },
        title: 'Project',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
