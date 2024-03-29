import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/control_amount/transfer_amount.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

import '../../models/account.dart';
import 'accounts_tile.dart';

class AccountsListView2 extends StatelessWidget {
  final int index1;
  const AccountsListView2({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size;
    size = MediaQuery.of(context).size;
    var width = size.width;
    List<Account> accountsList =
        Provider.of<AccountData>(context, listen: false).accounts;

    List<Account> filter = [];

    for (var i = 0; i < index1; i++) {
      filter.add(accountsList[i]);
    }
    for (var i = index1 + 1; i < accountsList.length; i++) {
      filter.add(accountsList[i]);
    }

    return Consumer<AccountData>(
      builder: ((context, accountData, child) {
        return ListView.separated(
          itemBuilder: (context, index2) {
            // accountsList.where((x) => x.name < index1);

            return AccountsListTile(
              account: filter[index2],
              onTap: () {
                // ignore: avoid_print

                showModalBottomSheetMetod(
                    context,
                    TransferAmount(
                      index1: index1,
                      index2: filter[index2].q - 1,
                    ));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 2,
            indent: width / 5,
            height: 5,
          ),
          itemCount: filter.length,
        );
      }),
    );
  }
}
