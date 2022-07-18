import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';
import 'package:provider/provider.dart';

InkWell recordCardInfo(Record record, BuildContext context,
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, int indexx) {
  return InkWell(
    onTap: () {
      return Provider.of<AccountData>(context, listen: false)
          .removeRecord(snapshot, index, indexx);
    },
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (record.action == 1)
                ? ([Colors.deepOrange, Colors.red])
                : (record.action == 2)
                    ? ([Colors.green, Colors.teal])
                    : ([
                        Colors.grey,
                        const Color.fromARGB(66, 255, 255, 255),
                      ]),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  record.name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: (record.action == 1)
                  ? Text(
                      NumberFormat("-###,###,#### \$").format(record.amount),
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      NumberFormat("###,###,#### \$").format(record.amount),
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}
