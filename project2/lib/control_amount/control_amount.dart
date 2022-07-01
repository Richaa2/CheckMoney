import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Потім Доробити !!!
class ControlAmount extends StatelessWidget {
  // void Function(int, AccountMoney) actionDo;
  final String action;

  final int index;
  const ControlAmount({
    Key? key,
    required this.action,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Text('$action amount'),
          TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isEmpty) {
                value = '';
              } else {
                // inputAmount = int.parse(value);
              }
            },
          ),
          // ElevatedButton(
          //     style: raisedButtonStyle,
          //     onPressed: () {
          //       Provider.of<AccountData>(context, listen: false)
          //           .addAmountOnScreen(
          //               inputAmount,
          //               Provider.of<AccountData>(context, listen: false)
          //                   .accounts[index],
          //               Provider.of<AccountData>(context, listen: false)
          //                   .records[index]);

          //       Navigator.popUntil(context, ModalRoute.withName('/'));
          //     },
          //     child: Text(action))
        ],
      ),
    );
  }
}
