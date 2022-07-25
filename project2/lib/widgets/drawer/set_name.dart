import 'package:flutter/material.dart';

class SetName extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  const SetName({
    Key? key,
    this.onChanged,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: const Text('CHANGE'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
