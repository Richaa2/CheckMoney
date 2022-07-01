import 'package:flutter/material.dart';

import 'package:project2/widgets/accounts_widgets/accounts_list.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: AccountsListView(),
          ),
        ],
      ),
    );
  }
}
