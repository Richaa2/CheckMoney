import 'package:flutter/material.dart';

import '../widgets/records_widgets/records_listview.dart';

Color color = Colors.transparent;
Color selectedColor = Colors.white;
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
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
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
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
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
        ],
      ),
    );
  }
}

class RecordTabs extends StatelessWidget {
  final int index;
  const RecordTabs({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: RecordsListView(
          indexx: index,
        ))
      ],
    );
  }
}

// class RecordTabs extends StatelessWidget {
//   final int index;
//   const RecordTabs({
//     Key? key,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection('record')
//             .orderBy('dateTime')
//             .snapshots(),
//         builder: (context, snapshot) {
//           return Expanded(
//             child: Column(
//               children: [
//                 // Expanded(
//                 //   child: RecordsListView(
//                 //     indexx: index,
//                 //   ),
//                 // ),
//               ],
//             ),
//           );
//         });
//   }
// }
