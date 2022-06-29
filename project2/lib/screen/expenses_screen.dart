import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

import '../widgets/expenses_icon_button.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        final int index;
        final expenses = accountData.expenses;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ExpensesIconButton(
                      amount: expenses[0].amount.toInt(),
                      color: expenses[0].color,
                      icon: expenses[0].icon,
                      title: expenses[0].name,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    ExpensesIconButton(
                      amount: expenses[1].amount.toInt(),
                      color: expenses[1].color,
                      icon: expenses[1].icon,
                      title: expenses[1].name,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    ExpensesIconButton(
                      amount: expenses[2].amount.toInt(),
                      color: expenses[2].color,
                      icon: expenses[2].icon,
                      title: expenses[2].name,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    ExpensesIconButton(
                      amount: expenses[3].amount.toInt(),
                      color: expenses[3].color,
                      icon: expenses[3].icon,
                      title: expenses[3].name,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        ExpensesIconButton(
                          amount: expenses[3].amount.toInt(),
                          color: expenses[3].color,
                          icon: expenses[3].icon,
                          title: expenses[3].name,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        ExpensesIconButton(
                          amount: expenses[3].amount.toInt(),
                          color: expenses[3].color,
                          icon: expenses[3].icon,
                          title: expenses[3].name,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    Center(),
                    Column(
                      children: [],
                    )
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [],
                )
              ],
            ),
          ),
        );
        ;
      },
    );
  }
}
