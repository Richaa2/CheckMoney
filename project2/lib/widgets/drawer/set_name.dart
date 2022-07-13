import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

class SetName extends StatelessWidget {
  void Function(String)? onChanged;
  void Function()? onPressed;
  SetName({
    Key? key,
    this.onChanged,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String name;
    return SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 300),
          title: const Text(
            'Name',
            textAlign: TextAlign.start,
          ),
          content: Column(
            children: [
              TextField(onChanged: onChanged),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: Text('CHANGE'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
