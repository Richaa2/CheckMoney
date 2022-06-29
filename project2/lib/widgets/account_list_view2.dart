import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/control_amount/transfer_amount.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';

import 'accounts_tile.dart';

class AccountsListView2 extends StatelessWidget {
  int index1;
  AccountsListView2({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.separated(
        itemBuilder: (context, index2) {
          // accountData.accounts.removeAt(index1);
          final accountsName = accountData.accounts[index2].name;
          final accountssMoney = accountData.accounts[index2].money;

          return AccountsListTile(
            amount: accountssMoney,
            nameTitle: accountsName,
            onTap: () {
              print(accountssMoney);

              showModalBottomSheetMetod(
                  context,
                  TransferAmount(
                    index1: index1,
                    index2: index2,
                  ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.white,
          height: 3,
        ),
        itemCount: accountData.accounts.length,
      );
    }));
  }
}
