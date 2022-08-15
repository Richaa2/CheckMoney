import 'dart:developer';
import 'package:should_rebuild/should_rebuild.dart' as re;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:project2/bloc/account_bloc.dart';
import 'package:project2/bloc/account_event.dart';
import 'package:project2/bloc/account_state.dart';
import 'package:project2/main_page.dart';

import 'package:project2/models/account.dart';

import 'package:project2/models/account_data.dart';

import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';
import 'package:provider/provider.dart';

import '../../control_amount/control_account_screen.dart';
import 'accounts_tile.dart';

class AccountsListView extends StatelessWidget {
  int? sum;
  AccountsListView({Key? key, this.sum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var accountss = Provider.of<List<AccountFirebase>>(context);

    // if (accountData.accounts.isEmpty) {
    //   accountData.getAccountStream();
    // }

    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('userInfo')
            .snapshots(),
        builder: (context, snapshotInfo) {
          return StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .collection('account')
                  .orderBy("q")
                  .snapshots(),
              builder: (context, snapshot) {
                // if (accounts.isEmpty) {
                //   Provider.of<AccountData>(context, listen: false)
                //       .addAccountFirebase(Account(
                //           colorValue: Colors.tealAccent.value.toString(),
                //           name: 'First account',
                //           money: 0,
                //           icon: Icons.credit_card.codePoint.toString(),
                //           id: 'z',
                //           q: 1));
                // }

                if (snapshotInfo.hasData) {
                  return Consumer<AccountData>(
                    builder: ((context, accountData, child) {
                      if (snapshot.hasData && snapshot.data!.size > 0) {}

                      Size size;
                      size = MediaQuery.of(context).size;
                      var height = size.height;
                      var width = size.width;

                      return BlocConsumer<AccountBloc, AccountState>(
                          listener: (((context, state) {
                            log(state.toString());

                            if (state is AccountLoadedState) {
                              print(99);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('Users is Loaded'),
                              //   ),
                              // );
                            }
                          })),
                          buildWhen: (previous, current) =>
                              snapshot.hasData ||
                              previous is AccountLoadedState &&
                                  snapshot.hasData,
                          builder: (context, state) {
                            final AccountBloc accountBloc =
                                context.read<AccountBloc>();

                            if (state is AccountLoadingState) {
                              FlutterNativeSplash.remove();

                              accountBloc.add(AccountLoadEvent());

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            // if (state is AccountLoadedState &&
                            //     !snapshot.hasData) {
                            //   return const Center(
                            //     child: Text(
                            //       'Account list is empty. Please create account 2',
                            //       style: TextStyle(fontSize: 20),
                            //     ),
                            //   );
                            // }
                            List<Account> accountsList = accountData.accounts;
                            final accounts = snapshot.data!.docs;
                            final accountsLast = snapshot.data!.docs.last;

                            if (state is AccountLoadedState &&
                                snapshot.hasData &&
                                snapshot.data!.size > 0 &&
                                accountsList.length != accounts.length) {
                              print('snapshot has data');
                              // List<Account> accountsList = accountData.accounts;
                              // final accounts = snapshot.data!.docs;
                              // final accountsLast = snapshot.data!.docs.last;

                              if (accountsList.isEmpty) {
                                if (accountsList.length < accounts.length) {
                                  for (var account in accounts) {
                                    final accountRow = Account(
                                        colorValue: account['color'],
                                        name: account['name'],
                                        money: account['money'],
                                        icon: account['icon'],
                                        id: account['id'] ?? 'nothing',
                                        q: account['q']);
                                    accountsList.add(accountRow);
                                  }
                                }
                              }
                              if (accounts.length > accountsList.length) {
                                accountsList.insert(
                                    accounts.length - 1,
                                    Account(
                                      colorValue: accountsLast['color'],
                                      icon: accountsLast['icon'],
                                      id: accountsLast['id'],
                                      money: accountsLast['money'],
                                      name: accountsLast['name'],
                                      q: accountsLast['q'],
                                    ));
                              }

                              FlutterNativeSplash.remove();
                              List<Account> accountsListState =
                                  state.loadedAccount;
                            } else if (!snapshot.hasData ||
                                snapshot.hasData && snapshot.data!.size == 0) {
                              return const Center(
                                child: Text(
                                  'Account list is empty. Please create account ',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              );
                            }

                            if (state is AccountLoadedState &&
                                accountsList.length == accounts.length) {
                              if (accounts.length == accountsList.length) {
                                sum =
                                    Provider.of<AccountData>(context).updateSum(
                                  snapshotInfo,
                                );
                              }
                              FlutterNativeSplash.remove();
                              List<Account> accountsListState =
                                  state.loadedAccount;
                              return re.ShouldRebuild<listViewBuild>(
                                shouldRebuild: ((oldWidget, newWidget) =>
                                    oldWidget.accountsListState.last.q !=
                                    newWidget.accountsListState.length),
                                child: listViewBuild(
                                  sum: sum,
                                  accountsListState: accountData.accounts,
                                  width: width,
                                  snapshot: snapshot,
                                  accountData: accountData,
                                ),
                              );
                            }

                            if (state is AccountErrorState) {
                              return const Center(
                                child: Text(
                                  'Error fetching users',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          });
                    }),
                  );
                }
                return Container();
              });
        });
  }
}

class listViewBuild extends StatelessWidget {
  const listViewBuild({
    Key? key,
    required this.sum,
    required this.accountsListState,
    required this.width,
    required this.snapshot,
    required this.accountData,
  }) : super(key: key);
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final AccountData accountData;
  final int? sum;
  final List<Account> accountsListState;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        print('Listview');
        accountData.updateIndex(index, snapshot);

        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Accounts',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '\$$sum',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                AccountsListTile(
                  onDismissible: snapshot.hasData
                      ? (direction) =>
                          accountData.removeAccount(snapshot, index)
                      : null,
                  account: accountsListState[index],
                  onTap: () {
                    print(accountsListState[index].money);

                    showModalBottomSheetMetod(
                        context,
                        ControlAccountScreen(
                          index: index,
                        ));
                  },
                ),
              ],
            ),
          );
        }

        // if (index > accountData.accounts.length - 2) {
        //   accountData.load();
        // }

        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: AccountsListTile(
            onDismissible: snapshot.hasData
                ? (direction) => accountData.removeAccount(
                      snapshot,
                      index,
                    )
                : null,
            account: accountsListState[index],
            onTap: () {
              print(accountsListState[index].money);

              showModalBottomSheetMetod(
                  context,
                  ControlAccountScreen(
                    index: index,
                  ));
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 2,
        indent: width / 5,
        height: 5,
      ),
      itemCount: accountsListState.length,
    );
  }
}
