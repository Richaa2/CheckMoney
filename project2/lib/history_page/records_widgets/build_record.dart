import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/history_page/records_widgets/record_card_info.dart';

import 'package:project2/models/history.dart';

Widget buildRecord(
  int indexx,
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
          child: recordCardInfo(record, context, snapshot, index, indexx),
        ),
      ],
    ),
  );
}
