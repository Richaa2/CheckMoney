import 'package:flutter/material.dart';
import 'package:project2/models/income.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

class IncomesIconButton extends StatelessWidget {
  final int? indexForTab;
  final int index;
  final void Function()? onTap;
  const IncomesIconButton({
    Key? key,
    this.indexForTab,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      int amountt = 0;
      final int lengthList = accountData.incomes.length;
      // .currentIncome(
      //     Provider.of<AccountData>(context, listen: false).incomeAmounts,
      //     indexForTab)
      // .length;

      if (index + 1 > lengthList) {
        return const SizedBox(
          width: 60,
          height: 120,
        );
      } else if (index + 1 <= lengthList &&
          index + 1 <=
              accountData
                  .currentIncome(
                      Provider.of<AccountData>(context, listen: false)
                          .incomeAmounts,
                      indexForTab)
                  .length) {
        final color = accountData.incomes[index].color;
        final title = accountData.incomes[index].name;
        final iconn = accountData.incomes[index].icon;
        int amountt = accountData
            .currentIncome(accountData.incomeAmounts, indexForTab)[index]
            .amount
            .toInt();

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
      if (index + 1 >=
          accountData
              .currentIncome(accountData.incomeAmounts, indexForTab)
              .length) {
        final color = accountData.incomes[index].color;
        final title = accountData.incomes[index].name;
        final iconn = accountData.incomes[index].icon;
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
    }));
  }
}
