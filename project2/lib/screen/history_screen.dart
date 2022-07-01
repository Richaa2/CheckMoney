import 'package:flutter/material.dart';

import '../widgets/records_widgets/records_listview.dart';

class HistoryScreen extends StatelessWidget {
  // PageController _controller = PageController();

  const HistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
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
        const SizedBox(
          height: 5,
        ),
        const Expanded(
          child: RecordsListView(),
        ),
      ],
    ));
  }
}
