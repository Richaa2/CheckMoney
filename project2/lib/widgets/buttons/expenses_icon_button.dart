import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

import '../../models/expense.dart';

class ExpensesIconButton extends StatelessWidget {
  final int index;
  final void Function()? onTap;
  final Expense expense;
  final void Function()? onLongPress;

  const ExpensesIconButton({
    Key? key,
    required this.index,
    this.onTap,
    required this.expense,
    this.onLongPress,
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
      return SizedBox(
        width: 60,
        height: 120,
        child: Column(
          children: [
            Text(expense.name),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onLongPress: onLongPress,
              child: CircleAvatar(
                backgroundColor: Color(int.parse(expense.color)),
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(IconData(int.parse(expense.icon),
                      fontFamily: 'MaterialIcons')),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('${expense.amount}'),
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
