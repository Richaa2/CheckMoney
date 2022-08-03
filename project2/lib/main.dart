import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:project2/bloc/account_bloc.dart';
import 'package:project2/bloc/account_event.dart';

import 'package:project2/models/account_data.dart';

import 'package:project2/reg/welcome_screen.dart';

import 'package:provider/provider.dart';

import 'add_page/add_account/add_account_screen.dart';
import 'main_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
          return BlocProvider(
            create: (context) => AccountBloc(
              accountData: context.read<AccountData>(),
            ),
            child: MaterialApp(
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
            ),
          );
        });
  }
}
