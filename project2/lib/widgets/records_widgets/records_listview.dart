import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/account_data.dart';
import 'build_record.dart';

class RecordsListView extends StatelessWidget {
  const RecordsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountData>(
      builder: ((context, accountData, child) {
        return listViewMetod(accountData);
      }),
    );
  }

  ListView listViewMetod(AccountData accountData) {
    String? prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y")
        .format(DateTime.now().add(const Duration(days: -1)));
    return ListView.builder(
      itemBuilder: (context, index) {
        final recordDate = accountData.records[index].dateTime;
        DateTime date = DateTime.fromMillisecondsSinceEpoch(recordDate);
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
                        ]),
                  )
                : const Offstage(),
            buildRecord(index, context, date, accountData.records[index]),
          ],
        );
      },
      itemCount: accountData.records.length,
    );
  }
}


  // return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: RecordsListTile(
        //       amount: recordsMoney.toInt(),
        //       nameTitle: recordsName,
        //       min: recordMin,
        //     ),
        //   );
        // },