import 'package:flutter/material.dart';

class AddAccountBalance extends StatelessWidget {
  final Widget textField;
  final Widget numPad;
  const AddAccountBalance({
    Key? key,
    required this.textField,
    required this.numPad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        children: [
          const Text('Account balance'),
          textField,
          // TextField(
          //   controller: _myController,
          //   showCursor: false,
          //   autofocus: true,
          //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //   keyboardType: TextInputType.none,
          //   textAlign: TextAlign.center,
          // ),
          numPad,
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
    );
  }
}
