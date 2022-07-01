import 'package:flutter/material.dart';
import 'package:project2/control_amount/add_amount.dart';
import 'package:project2/widgets/buttons/incomes_icon_button.dart';
import 'package:provider/provider.dart';

import 'package:project2/control_amount/transfer_amount.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

class IncomeGridView extends StatelessWidget {
  final int index1;
  const IncomeGridView({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(builder: ((context, accountData, child) {
      return GridView.builder(
        itemBuilder: (context, index2) {
          // accountData.accounts.removeAt(index1);

          final incomesName = accountData.incomes[index2].name;
          final incomesColor = accountData.incomes[index2].color;
          final incomesIcon = accountData.incomes[index2].icon;
          final incomesAmount = accountData.incomes[index2].amount.toInt();

          return IncomesIconButton(
            amount: incomesAmount,
            onTap: () {
              // ignore: avoid_print
              print(incomesAmount);

              showModalBottomSheetMetod(
                  context,
                  AddAmount(
                    index2: index2,
                    index1: index1,
                  ));
            },
            color: incomesColor,
            icon: incomesIcon,
            title: incomesName,
          );
        },
        itemCount: accountData.incomes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 80,
        ),
      );
    }));
  }
}
