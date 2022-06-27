import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/account_list_view2.dart';
import 'package:project2/widgets/accounts_listview.dart';

import '../widgets/showModalBottomSheetMetod.dart';
import 'add_account_screen.dart';

class SelectAccount extends StatelessWidget {
  int index1;
  SelectAccount({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                  '${sum} ',
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
            Expanded(
              child: AccountsListView2(
                index1: index1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
