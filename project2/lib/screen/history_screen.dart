import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';

import 'package:project2/widgets/accounts_listview.dart';
import 'package:project2/widgets/records_listview.dart';
import 'package:provider/provider.dart';

import '../widgets/showModalBottomSheetMetod.dart';
import 'add_account_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: RecordsListView(),
            ),
          ],
        ),
      ),
    );
  }
}
