import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            onChanged: (String value) {
              int inputAmount = int.parse(value);
            },
          ),
          ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Provider.of<AccountData>(context, listen: false)
                    .editAmountOnScreen(
                        inputAmount,
                        Provider.of<AccountData>(context, listen: false)
                            .accountsMoney[index]);
                print(Provider.of<AccountData>(context, listen: false)
                    .accountsMoney[index]
                    .money);

                Navigator.pop(context);
              },
              child: Text('Edit'))
        ],
      ),
    ));
  }
}
