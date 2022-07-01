// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/screen/control_account_screen.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';
import 'package:provider/provider.dart';

import 'accounts_tile.dart';

class AccountsListView extends StatelessWidget {
  const AccountsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final accountsName = accountData.accounts[index].name;
          final accountssMoney = accountData.accounts[index].money;

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
                    amount: accountssMoney,
                    nameTitle: accountsName,
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

          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: AccountsListTile(
              amount: accountssMoney,
              nameTitle: accountsName,
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
          color: Colors.white,
          height: 3,
        ),
        itemCount: accountData.accounts.length,
      );
    }));
  }
}
