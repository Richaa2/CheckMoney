import 'package:flutter/material.dart';
import 'package:project2/models/account_for_firebase.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';

class AccountsListTileFirebase extends StatelessWidget {
  // final IconData? icon;
  // final Color? color;
  // final String nameTitle;
  // final int amount;
  final AccountFirebase account;
  final void Function() onTap;
  const AccountsListTileFirebase({
    Key? key,
    // required this.nameTitle,
    // required this.amount,
    required this.account,
    required this.onTap,
    // required this.color,
    // this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return ListTile(
          trailing: Text(account.id),
          onTap: onTap,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(int.parse(account.colorValue)),
            ),
            child: Icon(
                IconData(int.parse(account.icon), fontFamily: 'MaterialIcons')),
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
                fontSize: 17, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
