import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

import 'accounts_list_tile.dart';

class AccountsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final accountsName = accountData.accountsName[index];
          final accountsMoney = accountData.accountsMoney[index];

          return AccountsListTile(
            amount: accountsMoney,
            nameTitle: accountsName,
          );
        },
        itemCount: accountData.accountsName.length,
      );
    }));
  }
}
