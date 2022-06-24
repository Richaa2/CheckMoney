import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

import 'add_account_screen.dart';

class AddAmount extends StatelessWidget {
  int inputAmount = 0;
  AddAmount({Key? key, required this.index}) : super(key: key);
  int index;
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
              inputAmount = int.parse(value);
            },
          ),
          ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Provider.of<AccountData>(context, listen: false)
                    .addAmount(inputAmount, index);
                print(Provider.of<AccountData>(context, listen: false)
                    .accountsMoney[index]);

                Navigator.pop(context);
              },
              child: Text('Add'))
        ],
      ),
    ));
  }
}
