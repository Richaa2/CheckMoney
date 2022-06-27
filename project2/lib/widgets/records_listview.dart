import 'package:flutter/material.dart';
import 'package:project2/widgets/records_list_tile.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';

class RecordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final recordsName = accountData.records[index].name;
          final recordsMoney = accountData.records[index].amount;
          final recordMin = accountData.records[index].action;

          return RecordsListTile(
            amount: recordsMoney,
            nameTitle: recordsName,
            min: recordMin,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.white,
          height: 15,
        ),
        itemCount: accountData.records.length,
      );
    }));
  }
}
