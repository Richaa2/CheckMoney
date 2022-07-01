import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';

import 'package:project2/widgets/num_pad.dart';
import 'package:provider/provider.dart';

class AddAmount extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  final int index1;
  final int index2;
  AddAmount({Key? key, required this.index1, required this.index2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  'from  ${Provider.of<AccountData>(context).incomes[index2].name}'),
              const Text('Add amount'),
              Text(
                  'to account  ${Provider.of<AccountData>(context).accounts[index1].name}'),
            ],
          ),
          TextField(
            controller: _myController,
            showCursor: false,
            autofocus: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.none,
            textAlign: TextAlign.center,
            // onChanged: (value) {
            //   if (value.isEmpty) {
            //     value = '';
            //   } else {
            //     inputAmount = int.parse(value);
            //   }
            // },
          ),
          NumPad(
              delete: () {
                if (_myController.text.isEmpty) {
                } else {
                  _myController.text = _myController.text
                      .substring(0, _myController.text.length - 1);
                }
              },
              onSubmit: () {
                if (_myController.text.isEmpty) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                } else {
                  Provider.of<AccountData>(context, listen: false)
                      .addAmountOnScreen(
                    int.parse(_myController.text),
                    Provider.of<AccountData>(context, listen: false)
                        .accounts[index1],
                    Record(
                      name: Provider.of<AccountData>(context, listen: false)
                          .accounts[index1]
                          .name,
                      amount: int.parse(_myController.text),
                      dateTime: DateTime.now().millisecondsSinceEpoch,
                    ),
                    Provider.of<AccountData>(context, listen: false)
                        .incomes[index2],
                  );
                  // ignore: avoid_print
                  print(Provider.of<AccountData>(context, listen: false)
                      .accounts[index1]
                      .money);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
              controller: _myController),
        ],
      ),
    );
  }
}
