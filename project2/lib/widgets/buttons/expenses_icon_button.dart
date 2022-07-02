import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

class ExpensesIconButton extends StatelessWidget {
  final int index;

  const ExpensesIconButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final int lengthList =
        Provider.of<AccountData>(context, listen: false).expenses.length;

    if (index + 1 == index > lengthList) {
      return const SizedBox(
        width: 60,
        height: 120,
      );
    } else if (index + 1 <= lengthList) {
      final Color = Provider.of<AccountData>(context, listen: false)
          .expenses[index]
          .color;
      final Title =
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
            Text(Title),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundColor: Color,
              child: IconButton(
                onPressed: () {},
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
