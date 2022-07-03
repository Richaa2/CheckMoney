import 'package:flutter/material.dart';
import 'package:project2/control_amount/add_amount.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

import '../../widgets/accounts_widgets/accounts_tile.dart';

class AccountsListViewIncome extends StatelessWidget {
  final int index1;
  const AccountsListViewIncome({
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
          final accountsColor = accountData.accounts[index2].color;
          final accountsIcon = accountData.accounts[index2].icon;
          return AccountsListTile(
            amount: accountssMoney,
            nameTitle: accountsName,
            onTap: () {
              // ignore: avoid_print
              print(accountssMoney);

              showModalBottomSheetMetod(
                  context,
                  AddAmount(
                    index1: index2,
                    index2: index1,
                  ));
            },
            color: accountsColor,
            icon: accountsIcon,
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
