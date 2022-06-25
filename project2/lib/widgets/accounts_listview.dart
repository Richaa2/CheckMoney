import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';
import 'package:provider/provider.dart';

import 'accounts_list_tile.dart';

class AccountsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final accountsName = accountData.accountsName[index];
          final accountssMoney = accountData.accountsMoney[index];

          return AccountsListTile(
            amount: accountssMoney.money,
            nameTitle: accountsName,
            onTap: () {
              // Provider.of<AccountData>(context, listen: false).addAmount(
              //     Provider.of<AccountData>(context, listen: false)
              //         .accountsMoney
              //         .elementAt(index),
              //     100,
              //     index);
              // Provider.of<AccountData>(context, listen: false)
              //     .addAmount(inputAmount, index);

              // accountData.addAmountonscreen(100, accountssMoney);

              print(accountssMoney.money);

              showModalBottomSheetMetod(
                  context,
                  ControlAccountScreen(
                    index: index,
                  ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.white,
          height: 15,
        ),
        itemCount: accountData.accountsName.length,
      );
    }));
  }
}
