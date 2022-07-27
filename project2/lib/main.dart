import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:project2/models/account_data.dart';

import 'package:project2/reg/welcome_screen.dart';

import 'package:provider/provider.dart';

import 'add_page/add_account/add_account_screen.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:
                FirebaseAuth.instance.currentUser == null ? '/m' : '/',
            routes: {
              '/m': (context) => const WelcomeScreen(),
              '/': (context) => const MainPage(),
              '/addAcc': ((context) => const AddAccountScreen()),
              // '/addExp': ((context) =>  AddExpenseScreen()),
              // '/addInc': ((context) => const AddIncomeScreen()),
            },
            title: 'Project',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
          );
        });
  }
}
