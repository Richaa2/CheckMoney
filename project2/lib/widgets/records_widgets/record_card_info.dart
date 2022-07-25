import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    child: ListTile(
      tileColor: const Color.fromARGB(26, 96, 125, 139),
      trailing: Text(
        '\$${record.amount}',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: record.action == 1
                ? Colors.red
                : record.action == 2
                    ? Colors.green
                    : Colors.grey),
      ),
      leading: CircleAvatar(
        backgroundColor: Color(int.parse(record.color)),
        child: record.action == 3
            ? Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(int.parse(record.color)),
                ),
                child: Icon(
                  IconData(int.parse(record.icon), fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
              )
            : Icon(
                IconData(int.parse(record.icon), fontFamily: 'MaterialIcons'),
                color: Colors.white,
              ),
      ),
      title: Text(
        record.name,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: RichText(
          text: TextSpan(
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(
                  IconData(int.parse(record.icon2),
                      fontFamily: 'MaterialIcons'),
                  color: Colors.grey,
                  size: 19,
                ),
              ),
            ),
            TextSpan(text: record.subName),
          ])),
    ),
  );
}
