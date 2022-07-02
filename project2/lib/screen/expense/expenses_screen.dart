import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/expense/select_account_for_expense.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons/expenses_icon_button.dart';
import '../../widgets/show_modal_buttom_sheet_metod.dart';
import '../income/income_screen.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        void page(int index) {
          showModalBottomSheetMetod(
              context, SelectAccountForExpense(index1: index));
        }

        var sum = Provider.of<AccountData>(context).sumOfExpenses();

        return Scaffold(
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
                        children: [
                          ExpensesIconButton(
                              index: 0,
                              onTap: () {
                                page(0);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 4,
                              onTap: () {
                                page(4);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 6,
                              onTap: () {
                                page(6);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 8,
                              onTap: () {
                                page(8);
                              }),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ExpensesIconButton(
                                    index: 1,
                                    onTap: () {
                                      page(1);
                                    }),
                                ExpensesIconButton(
                                    index: 2,
                                    onTap: () {
                                      page(2);
                                    }),
                              ],
                            ),
                            Flexible(
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const IncomesScreen())));
                                  },
                                  child: PieChart(
                                    dataMap: Provider.of<AccountData>(context,
                                            listen: false)
                                        .dataMapExpenses,
                                    chartType: ChartType.ring,
                                    legendOptions:
                                        const LegendOptions(showLegends: false),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ExpensesIconButton(
                                    index: 9,
                                    onTap: () {
                                      page(9);
                                    }),
                                ExpensesIconButton(
                                    index: 10,
                                    onTap: () {
                                      page(10);
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ExpensesIconButton(
                              index: 3,
                              onTap: () {
                                page(3);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 5,
                              onTap: () {
                                page(5);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 7,
                              onTap: () {
                                page(7);
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          ExpensesIconButton(
                              index: 11,
                              onTap: () {
                                page(11);
                              }),
                        ],
                      )
                    ]),
              ),
            ]),
          ),
        );
      },
    );
  }
}
