import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';

class AccountsListTile extends StatelessWidget {
  // final IconData? icon;
  // final Color? color;
  // final String nameTitle;
  // final int amount;
  final void Function(DismissDirection)? onDismissible;
  final Account account;
  final void Function() onTap;
  const AccountsListTile({
    Key? key,
    // required this.nameTitle,
    // required this.amount,
    required this.account,
    required this.onTap,
    this.onDismissible,
    // required this.color,
    // this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: onDismissible,
          direction: DismissDirection.startToEnd,
          child: ListTile(
            trailing: Text('${account.q}'),
            onTap: onTap,
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(int.parse(account.colorValue)),
              ),
              child: Icon(IconData(int.parse(account.icon),
                  fontFamily: 'MaterialIcons')),
            ),
            title: Text(
              account.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              '${account.money}\$',
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
