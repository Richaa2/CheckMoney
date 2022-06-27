import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2/models/account.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../screen/add_account_screen.dart';

//Потім Доробити !!!
class ControlAmount extends StatelessWidget {
  void Function(int, AccountMoney) actionDo;
  String action;
  int inputAmount = 0;
  int index;
  ControlAmount({
    Key? key,
    required this.actionDo,
    required this.action,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Text('$action amount'),
          TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isEmpty) {
                value = '';
              } else {
                inputAmount = int.parse(value);
              }
            },
          ),
          ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Provider.of<AccountData>(context, listen: false)
                    .addAmountOnScreen(
                        inputAmount,
                        Provider.of<AccountData>(context, listen: false)
                            .accountsMoney[index],
                        Provider.of<AccountData>(context, listen: false)
                            .records[index]);

                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('$action'))
        ],
      ),
    ));
  }
}
