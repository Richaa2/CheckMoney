import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
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
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.amber,
            ),
            child: Icon(Icons.credit_card),
          ),
          title: Text(
            '$nameTitle',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            '${amount}\$',
            style: TextStyle(
                fontSize: 17, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
