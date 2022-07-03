import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../models/history.dart';
import '../widgets/records_widgets/records_listview.dart';

Color _color = Colors.transparent;
Color _selectedColor = Colors.white;
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

  void Function()? onItemTapped(int index) {
    setState(() {
      _tabController.animateTo(index);
      currentIndex = index;
    });
    print(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            bottom: TabBar(controller: _tabController, tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
          Tab(icon: Icon(Icons.directions_bike)),
        ])),
        body: TabBarView(controller: _tabController, children: [
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'june 2022',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
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

class tabBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final int index;

  tabBarButton({required this.index, required this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  currentIndex == index ? Color(0xFF6fa1ea) : _selectedColor),
        ),
      ),
    );
  }
}
