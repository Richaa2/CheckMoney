import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

import 'accounts_list_tile.dart';

class AccountsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final accounts = accountData.accounts[index];
          for (var accountsMoney in accounts.money as dynamic) {
            print(accountsMoney);
          }
          return AccountsListTile(
            amount: accounts.money,
            nameTitle: accounts.name,
          );
        },
        itemCount: accountData.accounts.length,
      );
    }));
  }
}
