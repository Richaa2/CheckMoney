import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  SingingAccount? _account;
  @override
  Widget build(BuildContext context) {
    var height;
    var width;
    Size size;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AlertDialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: width / 5, vertical: height / 3.3),
      title: const Text('What create'),
      content: Column(
        children: [
          InkWell(
            onTap: () {},
            child: RadioListTile<SingingAccount>(
              value: SingingAccount.account,
              groupValue: _account,
              onChanged: (SingingAccount? value) {
                setState(() {
                  if (value == _account) {
                    Navigator.pushNamed(context, '/addAcc');
                  } else {
                    _account = value;
                    Navigator.pushNamed(context, '/addAcc');
                  }
                });
              },
              title: const Text('Account'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: RadioListTile<SingingAccount>(
              value: SingingAccount.expense,
              groupValue: _account,
              onChanged: (SingingAccount? value) {
                setState(() {
                  if (value == _account) {
                    Navigator.pushNamed(context, '/addExp');
                  } else {
                    _account = value;
                    Navigator.pushNamed(context, '/addExp');
                  }
                });
              },
              title: const Text('Expense'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: RadioListTile<SingingAccount>(
              value: SingingAccount.income,
              groupValue: _account,
              onChanged: (SingingAccount? value) {
                setState(() {
                  if (value == _account) {
                    Navigator.pushNamed(context, '/addInc');
                  } else {
                    _account = value;
                    Navigator.pushNamed(context, '/addInc');
                  }
                });
              },
              title: const Text('Income'),
            ),
          ),
        ],
      ),
    );
  }
}

enum SingingAccount { account, expense, income }
