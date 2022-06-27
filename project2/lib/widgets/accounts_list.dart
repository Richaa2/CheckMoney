import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';
import 'package:provider/provider.dart';

import 'accounts_tile.dart';

class AccountsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final accountsName = accountData.accountsName[index];
          final accountssMoney = accountData.accountsMoney[index];

          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Accounts',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\$$sum ',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountsListTile(
                    amount: accountssMoney.money,
                    nameTitle: accountsName,
                    onTap: () {
                      print(accountssMoney.money);

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

          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: AccountsListTile(
              amount: accountssMoney.money,
              nameTitle: accountsName,
              onTap: () {
                print(accountssMoney.money);

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
          color: Colors.white,
          height: 3,
        ),
        itemCount: accountData.accountsName.length,
      );
    }));
  }
}
