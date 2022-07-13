import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project2/reg/login_screen.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/screen/account_screen.dart';

import 'package:project2/screen/add_account/add_account_screen.dart';
import 'package:project2/screen/add_ex_in/add_expense.dart';
import 'package:project2/screen/add_ex_in/add_income.dart';
import 'package:project2/screen/history_screen.dart';
import 'package:project2/reg/welcome_screen.dart';

import 'package:provider/provider.dart';

import 'screen/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final FirestoreServices _db = FirestoreServices();
    return ChangeNotifierProvider(
        create: (BuildContext context) => AccountData(),
        builder: (context, child) {
          // FirebaseAuth.instance.signOut();
          // Provider.of<AccountData>(context, listen: false).ClearLists();

          return MaterialApp(
            initialRoute:
                FirebaseAuth.instance.currentUser == null ? '/m' : '/',
            routes: {
              '/m': (context) => WelcomeScreen(),
              '/': (context) => MainPage(),
              '/addAcc': ((context) => const AddAccountScreen()),
              '/addExp': ((context) => const AddExpenseScreen()),
              '/addInc': ((context) => const AddIncomeScreen()),
            },
            title: 'Project',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
          );
        }

        // child: MaterialApp(
        //   initialRoute: '/',
        //   routes: {
        //     '/': (context) => const MainPage(),
        //     '/addAcc': (context) => const AddAccountScreen(),
        //     '/addExp': ((context) => const AddExpenseScreen()),
        //     '/addInc': ((context) => const AddIncomeScreen()),
        //   },
        //   title: 'Project',
        //   theme: ThemeData(
        //     brightness: Brightness.dark,
        //   ),
        // ),
        );
  }
}
