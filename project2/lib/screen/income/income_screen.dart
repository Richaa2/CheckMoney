import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/history_screen.dart';
import 'package:project2/screen/income/select_account_for_income.dart';

import 'package:provider/provider.dart';

import '../../widgets/buttons/incomes_icon_button.dart';
import '../../widgets/show_modal_buttom_sheet_metod.dart';

class IncomesScreen extends StatefulWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  State<IncomesScreen> createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: (BuildContext context, accountData, child) {
        // var sum = Provider.of<AccountData>(context).sumOfIncomes();

        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  bottom: PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: TabBar(controller: _tabController, tabs: const [
                  Tab(
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Week',
                  ),
                  Tab(
                    text: 'Month',
                  ),
                  Tab(
                    text: 'Year',
                  ),
                ]),
              )),
              body: TabBarView(
                controller: _tabController,
                children: [
                  IncomeTabs(
                    indexForTabs: 0,
                  ),
                  IncomeTabs(
                    indexForTabs: 1,
                  ),
                  IncomeTabs(
                    indexForTabs: 2,
                  ),
                  IncomeTabs(
                    indexForTabs: 3,
                  ),
                ],
              )),
        );
      },
    );
  }
}

class IncomeTabs extends StatelessWidget {
  final int indexForTabs;
  const IncomeTabs({
    Key? key,
    required this.indexForTabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void page(int index) {
      showModalBottomSheetMetod(context, SelectAccountForIncome(index1: index));
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomesIconButton(
                    index: 0, onTap: () => page(0), indexForTab: indexForTabs),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                    index: 4, onTap: () => page(4), indexForTab: indexForTabs),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                  index: 6,
                  onTap: () => page(6),
                  indexForTab: indexForTabs,
                ),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                    index: 8, onTap: () => page(8), indexForTab: indexForTabs),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IncomesIconButton(
                          index: 1,
                          onTap: () => page(1),
                          indexForTab: indexForTabs),
                      IncomesIconButton(
                          index: 2,
                          onTap: () => page(2),
                          indexForTab: indexForTabs),
                    ],
                  ),
                  Flexible(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: PieChart(
                          dataMap:
                              Provider.of<AccountData>(context, listen: false)
                                  .dataMapExpenses,
                          chartType: ChartType.ring,
                          legendOptions:
                              const LegendOptions(showLegends: false),
                          chartValuesOptions:
                              const ChartValuesOptions(showChartValues: false),
                          centerText: 'Sum',
                          centerTextStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IncomesIconButton(
                          index: 9,
                          onTap: () => page(9),
                          indexForTab: indexForTabs),
                      IncomesIconButton(
                          index: 10,
                          onTap: () => page(10),
                          indexForTab: indexForTabs),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                IncomesIconButton(
                    index: 3, onTap: () => page(3), indexForTab: indexForTabs),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                    index: 5, onTap: () => page(5), indexForTab: indexForTabs),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                    index: 7, onTap: () => page(7), indexForTab: indexForTabs),
                const Spacer(
                  flex: 1,
                ),
                IncomesIconButton(
                    index: 11,
                    onTap: () => page(11),
                    indexForTab: indexForTabs),
              ],
            )
          ]),
        ),
      ]),
    );
  }
}
