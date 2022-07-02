import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:project2/models/account_data.dart';

import 'package:provider/provider.dart';

import '../../widgets/buttons/incomes_icon_button.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        var sum = Provider.of<AccountData>(context).sumOfIncomes();

        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            IncomesIconButton(
                              index: 0,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 4,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 6,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 8,
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
                                children: const [
                                  IncomesIconButton(
                                    index: 1,
                                  ),
                                  IncomesIconButton(
                                    index: 2,
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
                                children: const [
                                  IncomesIconButton(
                                    index: 9,
                                  ),
                                  IncomesIconButton(
                                    index: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            IncomesIconButton(
                              index: 3,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 5,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 7,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            IncomesIconButton(
                              index: 11,
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
