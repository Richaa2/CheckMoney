import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';
import 'package:project2/widgets/num_pad.dart';
import 'package:provider/provider.dart';

import '../screen/add_account_screen.dart';

class AddAmount extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  int index;
  AddAmount({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        children: [
          Text('Add amount'),
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
                              .accountsMoney[index],
                          Record(
                              name: Provider.of<AccountData>(context,
                                      listen: false)
                                  .accountsName[index],
                              amount: int.parse(_myController.text),
                              dateTime: DateTime.now().millisecondsSinceEpoch));
                  print(Provider.of<AccountData>(context, listen: false)
                      .accountsMoney[index]
                      .money);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
              controller: _myController),
        ],
      ),
    ));
  }
}
