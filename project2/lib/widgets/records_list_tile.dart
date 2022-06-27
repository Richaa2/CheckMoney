import 'package:flutter/material.dart';

class RecordsListTile extends StatelessWidget {
  final String nameTitle;
  final int amount;
  bool min = false;

  RecordsListTile({
    Key? key,
    required this.nameTitle,
    required this.amount,
    required this.min,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: min
          ? Text(
              '-\$$amount',
              style: TextStyle(color: Colors.red),
            )
          : Text(
              '+\$$amount',
              style: TextStyle(color: Colors.green),
            ),
      leading: Icon(Icons.money),
      title: Text(
        '$nameTitle',
      ),
    );
  }
}
