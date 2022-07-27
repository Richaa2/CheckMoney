import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

import '../../models/income.dart';

class IncomesIconButton extends StatelessWidget {
  final int? indexForTab;
  final int index;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Income income;
  const IncomesIconButton({
    Key? key,
    this.indexForTab,
    required this.index,
    this.onTap,
    required this.income,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int lengthList = Provider.of<AccountData>(
      context,
    ).incomes.length;

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
            Text(income.name),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onLongPress: onLongPress,
              child: CircleAvatar(
                backgroundColor: Color(int.parse(income.color)),
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(IconData(int.parse(income.icon),
                      fontFamily: 'MaterialIcons')),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('${income.amount}'),
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
