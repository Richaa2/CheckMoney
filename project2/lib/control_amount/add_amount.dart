import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';
import 'package:provider/provider.dart';

import '../screen/add_account_screen.dart';

class AddAmount extends StatelessWidget {
  int inputAmount = 0;
  int index;
  AddAmount({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Text('Add amount'),
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
                        Record(
                            name:
                                Provider.of<AccountData>(context, listen: false)
                                    .accountsName[index],
                            amount: inputAmount));
                print(Provider.of<AccountData>(context, listen: false)
                    .accountsMoney[index]
                    .money);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Add'))
        ],
      ),
    ));
  }
}
