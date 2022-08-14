import 'package:firebase_auth/firebase_auth.dart';

import '../models/account.dart';

abstract class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  List<Account> loadedAccount;
  AccountLoadedState({required this.loadedAccount});
}

class AccountErrorState extends AccountState {}
