import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:project2/history_manager.dart';
import 'package:project2/utils.dart';

import 'container_wrapper.dart';
import 'history_list.dart';
import 'models/account_data.dart';
import 'models/history.dart';

late TabController _tabController;
final Color _color = Colors.transparent;
final Color _selectedColor = Colors.white;
int _currentIndex = 0;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
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

  void onItemTapped(int index) {
    _tabController.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

  List<Record> currentEntries(List<Record> entries, int index) {
    bool isToday(DateTime date) {
      var today = DateTime.now();

      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        return true;
      }
      return false;
    }

    DateTime today = DateTime.now();

    List<Record> currentEntries =
        Provider.of<AccountData>(context, listen: false).records;
    if (index == 0) {
      currentEntries = entries
          .where((entry) =>
              isToday(DateTime.fromMillisecondsSinceEpoch(entry.dateTime)))
          .toList();
    } else if (index == 1) {
      Duration week = Duration(days: 7);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(week) <
              1)
          .toList();
    } else if (index == 2) {
      Duration month = Duration(days: 30);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(month) <
              1)
          .toList();
    } else if (index == 3) {
      Duration year = Duration(days: 365);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(
                      DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                  .compareTo(year) <
              1)
          .toList();
    }

    currentEntries.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

    return currentEntries;
  }

  List<Widget> _buildStats(List<Record> entries) {
    List<Record> currentEntries = HistoryManager.manager.currentEntries(
        Provider.of<AccountData>(context, listen: false).records,
        _currentIndex);
    ;
    double summary = currentEntries.fold(0.0, (t, e) => e.amount.toDouble());

    List<Widget> statWidget = [
      Expanded(
        child: Text('Summary'),
      ),
    ];

    if (currentEntries.length > 0) {
      currentEntries.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));

      var firstDay =
          DateTime.fromMillisecondsSinceEpoch(currentEntries.first.dateTime);

      var lastDay =
          DateTime.fromMillisecondsSinceEpoch(currentEntries.last.dateTime);

      var days = firstDay.difference(lastDay).inDays + 1;
    }

    return statWidget;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0.0,
              height: 160.0,
              child: SizedBox(
                width: size.width,
                height: 160.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 0.7],
                        colors: [Colors.white.withOpacity(0.0), Colors.white]),
                  ),
                ),
              )),
          SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        tabBarButton(
                          index: 0,
                          name: 'Today',
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                        ),
                        tabBarButton(
                          name: '7 days',
                          index: 1,
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                        ),
                        tabBarButton(
                          name: '30 days',
                          index: 2,
                          onPressed: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                        ),
                        tabBarButton(
                          name: '365 days',
                          index: 3,
                          onPressed: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: HistoryLists(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ContainerWrapper(
                      widthScale: 1.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class tabBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final int index;

  tabBarButton({required this.index, required this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  _currentIndex == index ? Color(0xFF6fa1ea) : _selectedColor),
        ),
      ),
    ));
  }
}
