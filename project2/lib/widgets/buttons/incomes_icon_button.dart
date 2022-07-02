import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

class IncomesIconButton extends StatelessWidget {
  final int index;
  final void Function()? onTap;
  const IncomesIconButton({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int lengthList =
        Provider.of<AccountData>(context, listen: false).incomes.length;

    if (index + 1 > lengthList) {
      return const SizedBox(
        width: 60,
        height: 120,
      );
    } else if (index + 1 <= lengthList) {
      final Color =
          Provider.of<AccountData>(context, listen: false).incomes[index].color;
      final Title =
          Provider.of<AccountData>(context, listen: false).incomes[index].name;
      final iconn =
          Provider.of<AccountData>(context, listen: false).incomes[index].icon;
      final amountt = Provider.of<AccountData>(context, listen: false)
          .incomes[index]
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
