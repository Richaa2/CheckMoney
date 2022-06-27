import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../screen/add_account_screen.dart';

class TransferAmount extends StatelessWidget {
  int inputAmount = 0;
  int index1;
  int index2;
  TransferAmount({
    Key? key,
    required this.index1,
    required this.index2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Text('Transfer amount'),
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
                    .transferAmountOnScreen(
                        inputAmount,
                        Provider.of<AccountData>(context, listen: false)
                            .accountsMoney[index1],
                        Provider.of<AccountData>(context, listen: false)
                            .accountsMoney[index2]);
                print(Provider.of<AccountData>(context, listen: false)
                    .accountsMoney[index1]
                    .money);

                Navigator.pop(context);
              },
              child: Text('Trensfer'))
        ],
      ),
    ));
  }
}
