import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/bloc/account_event.dart';
import 'package:project2/bloc/account_state.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountData accountData;
  AccountBloc({required this.accountData}) : super(AccountLoadingState()) {
    on<AccountLoadEvent>((event, emit) {
      emit(AccountLoadingState());

      final List<Account> loadedAccountList = accountData.accounts;
      try {
        emit(AccountLoadedState(loadedAccount: loadedAccountList));
        print(loadedAccountList.length);
      } catch (e) {
        emit(AccountErrorState());
      }
    });

    on<AccountEmptyLoadEvent>(((event, emit) {
      emit(AccountEmptyState());
    }));
  }
}
