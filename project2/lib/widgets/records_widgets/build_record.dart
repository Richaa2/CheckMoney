import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:project2/models/history.dart';
import 'package:project2/widgets/records_widgets/record_card_info.dart';

Widget buildRecord(
  int index,
  BuildContext context,
  DateTime date,
  Record record,
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: recordCardInfo(record, context, snapshot, index),
        ),
      ],
    ),
  );
}
