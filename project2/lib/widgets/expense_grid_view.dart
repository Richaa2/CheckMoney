import 'package:flutter/material.dart';

import 'package:project2/control_amount/min_account.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

import 'buttons/expenses_icon_button.dart';

class ExpenseGridView extends StatelessWidget {
  final int index1;
  const ExpenseGridView({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return GridView.builder(
        itemBuilder: (context, index2) {
          final expensesAmount = accountData.expenses[index2].amount.toInt();

          return ExpensesIconButton(
            onTap: () {
              // ignore: avoid_print
              print(expensesAmount);

              showModalBottomSheetMetod(
                  context,
                  MinAmount(
                    index2: index2,
                    index1: index1,
                  ));
            },
            index: index2,
          );
        },
        itemCount: accountData.expenses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 80,
        ),
      );
    }));
  }
}
