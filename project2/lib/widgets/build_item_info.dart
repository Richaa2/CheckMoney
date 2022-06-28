import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/history.dart';

Card buildItemInfo(Record record, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: record.action
                ? [Colors.deepOrange, Colors.red]
                : [Colors.green, Colors.teal]),
      ),
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
            child: record.action
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
