import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/history.dart';
import 'package:provider/provider.dart';

import '../../models/account_data.dart';
import 'build_record.dart';

class RecordsListView extends StatelessWidget {
  const RecordsListView({Key? key, required this.indexx}) : super(key: key);
  final int indexx;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('record')
            .orderBy("dateTime")
            .snapshots(),
        builder: (context, snapshot) {
          return Consumer<AccountData>(
            builder: ((context, accountData, child) {
              return listViewMetod(accountData, snapshot);
            }),
          );
        });
  }

  Widget listViewMetod(
    AccountData accountData,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
  ) {
    List<Record> recordsList = accountData.records
      ..sort((v1, v2) => v2.dateTime.compareTo(v1.dateTime));

    if (snapshot.hasData) {
      final records = snapshot.data!.docs.reversed;

      if (recordsList.isEmpty) {
        if (recordsList.length < records.length) {
          for (var record in records) {
            final recordRow = Record(
                name: record['name'],
                amount: record['amount'],
                action: record['action'],
                id: record['id'],
                dateTime: record['dateTime'],
                color: record['color'],
                icon: record['icon'],
                subName: record['subName'],
                icon2: record['icon2']);
            recordsList.add(recordRow);
          }
        }
      }

      if (recordsList.length > records.length) {
        recordsList.clear();
      }

      String? prevDay;
      String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
      String yesterday = DateFormat("EEE, MMM d, y")
          .format(DateTime.now().add(const Duration(days: -1)));
      var sum = accountData.sumOfRecords(indexx);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "History",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '\$$sum',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: sum! >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  // var sum = Provider.of<AccountData>(context, listen: false)
                  //     .sumOfDay(accountData.records);

                  final recordDate = accountData.records[index].dateTime;
                  DateTime date =
                      DateTime.fromMillisecondsSinceEpoch(recordDate);
                  String dateString = DateFormat("EEE, MMM d, y").format(date);
                  String number = DateFormat("d").format(date);
                  String dayOfWeek = DateFormat("EEEE").format(date);
                  String mounthAndYear = DateFormat("MMMM  y").format(date);

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
                      showHeader
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 5, right: 5),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            title: Text(
                                              dayOfWeek,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              mounthAndYear,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            )
                          : const Offstage(),
                      buildRecord(
                        indexx,
                        index,
                        context,
                        date,
                        accountData.currentEntries(recordsList, indexx)[index],
                        snapshot,
                      ),
                    ],
                  );
                },
                itemCount: accountData
                    .currentEntries(accountData.records, indexx)
                    .length),
          ),
        ],
      );
    }
    if (snapshot.hasError) {
      print(snapshot.error);
      //! do any error handling here
    }
    return ListView();
  }
}
