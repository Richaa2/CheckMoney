import 'package:flutter/material.dart';
import 'package:project2/account_page/widgets/accounts_list.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
