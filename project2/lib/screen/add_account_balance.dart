import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../widgets/num_pad.dart';

class AddAccountBalance extends StatelessWidget {
  int inputMoney = 0;

  Widget TextField;
  Widget NumPad;
  AddAccountBalance({
    Key? key,
    required this.TextField,
    required this.inputMoney,
    required this.NumPad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        children: [
          Text('Account balance'),
          TextField,
          // TextField(
          //   controller: _myController,
          //   showCursor: false,
          //   autofocus: true,
          //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //   keyboardType: TextInputType.none,
          //   textAlign: TextAlign.center,
          // ),
          NumPad,
          // NumPad(
          //     delete: () {
          //       if (_myController.text.isEmpty) {
          //       } else {
          //         _myController.text = _myController.text
          //             .substring(0, _myController.text.length - 1);
          //       }
          //     },
          //     onSubmit: () {
          //       if (_myController.text.isEmpty) {
          //         Navigator.pop(context);
          //       } else {
          //         inputMoney = int.parse(_myController.text);
          //         Navigator.pop(context, inputMoney);
          //       }
          //     },
          //     controller: _myController),
        ],
      ),
    ));
  }
}
