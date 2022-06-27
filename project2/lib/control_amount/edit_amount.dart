import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../screen/add_account_screen.dart';

class EditAmount extends StatelessWidget {
  int inputAmount = 0;
  int index;
  EditAmount({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Text('Edit amount'),
          TextFormField(
            initialValue: Provider.of<AccountData>(context, listen: false)
                .accountsMoney[index]
                .money
                .toString(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isEmpty) {
                value = '';
              } else if (value == 0) {
                // inputAmount = Provider.of<AccountData>(context, listen: false)
                //     .accountsMoney[index]
                //     .money;

              } else {
                inputAmount = int.parse(value);
              }
            },
          ),
          ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                if (inputAmount != 0) {
                  Provider.of<AccountData>(context, listen: false)
                      .editAmountOnScreen(
                          inputAmount,
                          Provider.of<AccountData>(context, listen: false)
                              .accountsMoney[index]);
                }

                print(Provider.of<AccountData>(context, listen: false)
                    .accountsMoney[index]
                    .money);

                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Edit'))
        ],
      ),
    ));
  }
}
