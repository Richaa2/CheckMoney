import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

class ExpensesIconButton extends StatelessWidget {
  final int index;
  final void Function()? onTap;

  const ExpensesIconButton({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int lengthList =
        Provider.of<AccountData>(context, listen: false).expenses.length;

    if (index + 1 > lengthList) {
      return const SizedBox(
        width: 60,
        height: 120,
      );
    } else if (index + 1 <= lengthList) {
      final color = Provider.of<AccountData>(context, listen: false)
          .expenses[index]
          .color;
      final title =
          Provider.of<AccountData>(context, listen: false).expenses[index].name;
      final iconn =
          Provider.of<AccountData>(context, listen: false).expenses[index].icon;
      final amountt = Provider.of<AccountData>(context, listen: false)
          .expenses[index]
          .amount;
      return SizedBox(
        width: 60,
        height: 120,
        child: Column(
          children: [
            Text(title),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundColor: color,
              child: IconButton(
                onPressed: onTap,
                icon: Icon(iconn),
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('$amountt'),
          ],
        ),
      );
    }
    return const SizedBox(
      width: 60,
      height: 120,
    );
  }
}
