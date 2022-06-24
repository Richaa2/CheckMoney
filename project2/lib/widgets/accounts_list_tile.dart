import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsListTile extends StatelessWidget {
  String nameTitle;
  int amount;
  void Function() onTap;
  AccountsListTile({
    required this.nameTitle,
    required this.amount,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return ListTile(
          onTap: onTap,
          leading: Icon(Icons.money),
          title: Text('$nameTitle'),
          subtitle: Text('$amount\$'),
        );
      },
    );
  }
}
