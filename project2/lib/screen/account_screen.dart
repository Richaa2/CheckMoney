import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';

import 'package:project2/widgets/accounts_listview.dart';
import 'package:provider/provider.dart';

import '../widgets/showModalBottomSheetMetod.dart';
import 'add_account_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Scaffold(
      body: Padding(
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
              child: AccountsListView(),
            ),
          ],
        ),
      ),
    );
  }
}
