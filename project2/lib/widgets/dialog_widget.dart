import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../screen/main_page.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  SingingAccount? _account;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 230),
      title: Text('What create'),
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
              title: Text('Account'),
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
                    Navigator.pushNamed(context, '/addAcc');
                  } else {
                    _account = value;
                    Navigator.pushNamed(context, '/addAcc');
                  }
                });
              },
              title: Text('Expense'),
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
                    Navigator.pushNamed(context, '/addAcc');
                  } else {
                    _account = value;
                    Navigator.pushNamed(context, '/addAcc');
                  }
                });
              },
              title: Text('Income'),
            ),
          ),
        ],
      ),
    );
  }
}

enum SingingAccount { account, expense, income }
