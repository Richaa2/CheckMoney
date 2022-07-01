import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsListTile extends StatelessWidget {
  final Color? color;
  final String nameTitle;
  final int amount;
  final void Function() onTap;
  const AccountsListTile({
    Key? key,
    required this.nameTitle,
    required this.amount,
    required this.onTap,
    required this.color,
  }) : super(key: key);
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
              color: color,
            ),
            child: const Icon(Icons.credit_card),
          ),
          title: Text(
            nameTitle,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            '$amount\$',
            style: const TextStyle(
                fontSize: 17, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
