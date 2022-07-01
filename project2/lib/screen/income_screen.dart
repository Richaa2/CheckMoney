import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/expenses_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons/expenses_icon_button.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        final expenses = accountData.expenses;
        var sum = Provider.of<AccountData>(context).sumOfExpenses();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: Column(children: [
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ExpensesIconButton(
                              amount: expenses[0].amount.toInt(),
                              color: expenses[0].color,
                              icon: expenses[0].icon,
                              title: expenses[0].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[4].amount.toInt(),
                              color: expenses[4].color,
                              icon: expenses[4].icon,
                              title: expenses[4].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[6].amount.toInt(),
                              color: expenses[6].color,
                              icon: expenses[6].icon,
                              title: expenses[6].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[8].amount.toInt(),
                              color: expenses[8].color,
                              icon: expenses[8].icon,
                              title: expenses[8].name,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ExpensesIconButton(
                                    amount: expenses[1].amount.toInt(),
                                    color: expenses[1].color,
                                    icon: expenses[1].icon,
                                    title: expenses[1].name,
                                  ),
                                  ExpensesIconButton(
                                    amount: expenses[2].amount.toInt(),
                                    color: expenses[2].color,
                                    icon: expenses[2].icon,
                                    title: expenses[2].name,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: PieChart(
                                      dataMap: Provider.of<AccountData>(context,
                                              listen: false)
                                          .dataMapExpenses,
                                      chartType: ChartType.ring,
                                      legendOptions: const LegendOptions(
                                          showLegends: false),
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                              showChartValues: false),
                                      centerText: '$sum',
                                      centerTextStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ExpensesIconButton(
                                    amount: expenses[9].amount.toInt(),
                                    color: expenses[9].color,
                                    icon: expenses[9].icon,
                                    title: expenses[9].name,
                                  ),
                                  ExpensesIconButton(
                                    amount: expenses[10].amount.toInt(),
                                    color: expenses[10].color,
                                    icon: expenses[10].icon,
                                    title: expenses[10].name,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            ExpensesIconButton(
                              amount: expenses[3].amount.toInt(),
                              color: expenses[3].color,
                              icon: expenses[3].icon,
                              title: expenses[3].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[5].amount.toInt(),
                              color: expenses[5].color,
                              icon: expenses[5].icon,
                              title: expenses[5].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[7].amount.toInt(),
                              color: expenses[7].color,
                              icon: expenses[7].icon,
                              title: expenses[7].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            ExpensesIconButton(
                              amount: expenses[11].amount.toInt(),
                              color: expenses[11].color,
                              icon: expenses[11].icon,
                              title: expenses[11].name,
                            ),
                          ],
                        )
                      ]),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
