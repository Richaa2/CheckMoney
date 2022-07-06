// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/firestore_services.dart';
import 'package:project2/models/account.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/models/account_for_firebase.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:project2/widgets/accounts_widgets/accounts_tile_firebase.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';
import 'package:provider/provider.dart';

import 'accounts_tile.dart';

class AccountsListView extends StatelessWidget {
  const AccountsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountss = Provider.of<List<AccountFirebase>>(context);

    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      if (accountData.accounts.isEmpty) {
        accountData.getAccountStream();
      }
      return ListView.separated(
        itemBuilder: (context, index) {
          final accountsName = accountData.accounts[index].name;
          final accountssMoney = accountData.accounts[index].money;
          final accountColor = accountData.accounts[index].colorValue;
          final accountsIcon = accountData.accounts[index].icon;

          AccountFirebase account = accountss[index];

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
                        '\$$sum ',
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
                    account: accountData.accounts[index],
                    onTap: () {
                      print(accountssMoney);

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

          if (index > accountData.accounts.length - 2) {
            accountData.load();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: AccountsListTileFirebase(
              account: account,
              onTap: () {
                print(accountssMoney);

                showModalBottomSheetMetod(
                    context,
                    ControlAccountScreen(
                      index: index,
                    ));
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 5,
        ),
        itemCount: accountData.accounts.length,
      );
    }));
  }
}
