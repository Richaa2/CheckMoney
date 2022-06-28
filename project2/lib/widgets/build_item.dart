import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/models/history.dart';

import 'build_item_info.dart';

Widget buildItem(
    int index, BuildContext context, DateTime date, Record record) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: buildItemInfo(record, context),
        ),
      ],
    ),
  );
}
