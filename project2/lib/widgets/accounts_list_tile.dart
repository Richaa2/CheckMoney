import 'package:flutter/material.dart';

class AccountsListTile extends StatelessWidget {
  String nameTitle;
  String amount;
  AccountsListTile({
    required this.nameTitle,
    required this.amount,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.money),
      title: Text('$nameTitle'),
      subtitle: Text('$amount\$'),
    );
  }
}
