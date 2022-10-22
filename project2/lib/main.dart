import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:project2/auth/auth_repository.dart';
import 'package:project2/bloc/account_bloc.dart';
import 'package:project2/firebase_options.dart';

import 'package:project2/models/account_data.dart';

import 'package:project2/reg/welcome_screen.dart';

import 'package:provider/provider.dart';

import 'add_page/add_account/add_account_screen.dart';
import 'auth/bloc/auth_bloc.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'CheckMoney3',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: ChangeNotifierProvider(
            create: (BuildContext context) => AccountData(),
            builder: (context, child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AccountBloc(
                      accountData: context.read<AccountData>(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => AuthBloc(
                      authRepository:
                          RepositoryProvider.of<AuthRepository>(context),
                    ),
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,

                  home:
                      FirebaseAuth.instanceFor(app: Firebase.app('CheckMoney3'))
                                  .currentUser ==
                              null
                          ? const WelcomeScreen()
                          : const MainPage(),

                  // initialRoute:
                  // FirebaseAuth.instanceFor(app: Firebase.app('CheckMoney3'))
                  //             .currentUser ==
                  //         null
                  //         ? '/m'
                  //         : '/',
                  routes: {
                    // '/m': (context) => const WelcomeScreen(),
                    // '/': (context) => const MainPage(),
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
            }));
  }
}
