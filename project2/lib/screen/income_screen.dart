import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:project2/models/account_data.dart';

import 'package:provider/provider.dart';

import '../widgets/buttons/incomes_icon_button.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        final incomes = accountData.incomes;
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
                            IncomesIconButton(
                              amount: incomes[0].amount.toInt(),
                              color: incomes[0].color,
                              icon: incomes[0].icon,
                              title: incomes[0].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[4].amount.toInt(),
                              color: incomes[4].color,
                              icon: incomes[4].icon,
                              title: incomes[4].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[6].amount.toInt(),
                              color: incomes[6].color,
                              icon: incomes[6].icon,
                              title: incomes[6].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[8].amount.toInt(),
                              color: incomes[8].color,
                              icon: incomes[8].icon,
                              title: incomes[8].name,
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
                                  IncomesIconButton(
                                    amount: incomes[1].amount.toInt(),
                                    color: incomes[1].color,
                                    icon: incomes[1].icon,
                                    title: incomes[1].name,
                                  ),
                                  IncomesIconButton(
                                    amount: incomes[2].amount.toInt(),
                                    color: incomes[2].color,
                                    icon: incomes[2].icon,
                                    title: incomes[2].name,
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
                                  IncomesIconButton(
                                    amount: incomes[9].amount.toInt(),
                                    color: incomes[9].color,
                                    icon: incomes[9].icon,
                                    title: incomes[9].name,
                                  ),
                                  IncomesIconButton(
                                    amount: incomes[10].amount.toInt(),
                                    color: incomes[10].color,
                                    icon: incomes[10].icon,
                                    title: incomes[10].name,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IncomesIconButton(
                              amount: incomes[3].amount.toInt(),
                              color: incomes[3].color,
                              icon: incomes[3].icon,
                              title: incomes[3].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[5].amount.toInt(),
                              color: incomes[5].color,
                              icon: incomes[5].icon,
                              title: incomes[5].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[7].amount.toInt(),
                              color: incomes[7].color,
                              icon: incomes[7].icon,
                              title: incomes[7].name,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              amount: incomes[11].amount.toInt(),
                              color: incomes[11].color,
                              icon: incomes[11].icon,
                              title: incomes[11].name,
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
