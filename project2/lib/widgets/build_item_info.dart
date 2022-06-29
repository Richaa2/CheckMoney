import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/history.dart';

Card buildItemInfo(Record record, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: (record.action == 1)
                  ? ([Colors.deepOrange, Colors.red])
                  : (record.action == 2)
                      ? ([Colors.green, Colors.teal])
                      : ([Colors.grey, Color.fromARGB(66, 255, 255, 255)]))),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
  );
}
