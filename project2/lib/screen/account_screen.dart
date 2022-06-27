import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';

import 'package:project2/widgets/accounts_list.dart';
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
      body: Column(
        children: [
          Expanded(
            child: AccountsListView(),
          ),
        ],
      ),
    );
  }
}
