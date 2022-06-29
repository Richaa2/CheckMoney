import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: Size.fromHeight(50),
);

class AddAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String inputName = 'without name';
    int inputMoney = 0;

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text('Name'),
                          TextField(
                            onChanged: (nameText) {
                              inputName = nameText;
                            },
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text('Amount'),
                          TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (moneyAm) {
                              inputMoney = int.parse(moneyAm);
                            },
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Provider.of<AccountData>(context, listen: false)
                      .addAccount(Account(name: inputName, money: inputMoney));

                  Navigator.pop(context);
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
