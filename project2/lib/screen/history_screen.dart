import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';

import '../widgets/records_widgets/records_listview.dart';

int currentIndex = 0;

class HistoryScreen extends StatefulWidget {
  // PageController _controller = PageController();

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
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
        body: TabBarView(controller: _tabController, children: const [
          RecordTabs(
            index: 0,
          ),
          RecordTabs(
            index: 1,
          ),
          RecordTabs(
            index: 2,
          ),
          RecordTabs(
            index: 3,
          ),
        ]));
  }
}

class RecordTabs extends StatelessWidget {
  final int index;
  const RecordTabs({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sum =
        Provider.of<AccountData>(context, listen: false).sumOfRecords(index);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   'june 2022',
                //   style: TextStyle(
                //       color: Colors.grey,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700),
                // ),
                Text(
                  '+\$$sum',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: RecordsListView(
            indexx: index,
          ),
        ),
      ],
    );
  }
}
