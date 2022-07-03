import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';
import 'package:project2/shadow_text.dart';
import 'package:project2/widgets/records_widgets/build_record.dart';
import 'package:provider/provider.dart';

import 'container_wrapper.dart';
import 'history_manager.dart';
import 'history_page.dart';

class HistoryLists extends StatelessWidget {
  List<Record> currentEntries = [];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 4; i++) {
      List<Record> currentEntries = HistoryManager.manager.currentEntries(
          Provider.of<AccountData>(context, listen: false).records, i);
    }
    return Consumer<AccountData>(
      builder: ((context, accountData, child) {
        return _buildListsWithEntries(accountData);
      }),
    );
  }

  ListView _buildListsWithEntries(AccountData accountData) {
    String? prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y")
        .format(DateTime.now().add(const Duration(days: -1)));

    // if (currentEntries.length == 0) {
    //   // Empty list
    //   // return Center(
    //   //     child: Padding(
    //   //         padding: EdgeInsets.symmetric(horizontal: 8.0),
    //   //         child: ContainerWrapper(
    //   //             widthScale: 1.0,
    //   //             child: Padding(
    //   //               padding: EdgeInsets.all(16.0),
    //   //               child: Text(
    //   //                 'You have not drunk anything yet! To add a drink go to the Today page and use the menu with drinks.',
    //   //                 textAlign: TextAlign.center,
    //   //                 style: TextStyle(
    //   //                     color: const Color(0xFF363535),
    //   //                     fontWeight: FontWeight.w300),
    //   //               ),
    //   //             ))));
    // }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final records = accountData.records;
        final recordDate = accountData.records[index].dateTime;
        DateTime date = DateTime.fromMillisecondsSinceEpoch(recordDate);
        String dateString = DateFormat("EEE, MMM d, y").format(date);
        String number = DateFormat("d").format(date);
        String dayOfWeek = DateFormat("EEEE").format(date);
        String mounthAndYear = DateFormat("MMMM  y").format(date);
        DateTime today = DateTime.now();

        void Function()? buildList =
            accountData.buildListsWithEntries(currentEntries);
        if (index == 0) {
          currentEntries = records
              .where((entry) => HistoryManager.manager
                  .isToday(DateTime.fromMillisecondsSinceEpoch(entry.dateTime)))
              .toList();
        } else if (index == 1) {
          Duration week = Duration(days: 7);
          currentEntries = records
              .where((entry) =>
                  today
                      .difference(
                          DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                      .compareTo(week) <
                  1)
              .toList();
        } else if (index == 2) {
          Duration month = Duration(days: 30);
          currentEntries = records
              .where((entry) =>
                  today
                      .difference(
                          DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                      .compareTo(month) <
                  1)
              .toList();
        } else if (index == 3) {
          Duration year = Duration(days: 365);
          currentEntries = records
              .where((entry) =>
                  today
                      .difference(
                          DateTime.fromMillisecondsSinceEpoch(entry.dateTime))
                      .compareTo(year) <
                  1)
              .toList();
        }

        currentEntries.sort((a, b) => b.dateTime.compareTo(a.dateTime));

        if (today == dateString) {
          dayOfWeek = 'Today';
        } else if (yesterday == dateString) {
          dayOfWeek = "Yesteday";
        }

        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(onPressed: buildList, child: Text('update')),
            showHeader
                ? Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ListTile(
                            dense: true,
                            leading: Text(
                              number,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontSize: 25,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                              dayOfWeek,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              mounthAndYear,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ListTile(
                            title: Text(
                              '+\$400',
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const Offstage(),
            buildRecord(index, context, date, accountData.records[index]),
          ],
        );
      },
      itemCount: currentEntries.length,
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   if (lists.isEmpty) {
  //     _buildListsWithEntries();
  //   }

  //   return TabBarView(
  //     controller: widget.tabController,
  //     physics: const NeverScrollableScrollPhysics(),
  //     children: lists,
  //   );
  // }

