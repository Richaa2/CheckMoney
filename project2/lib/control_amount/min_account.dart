import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../models/history.dart';

import '../widgets/num_pad.dart';

class MinAmount extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  final int index1;
  final int index2;
  MinAmount({
    Key? key,
    required this.index1,
    required this.index2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('account').snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      '  ${Provider.of<AccountData>(context).expenses[index2].name}'),
                  const Text('Withdraw money'),
                  Text(
                      '  ${Provider.of<AccountData>(context).accounts[index1].name}'),
                ],
              ),
              TextField(
                controller: _myController,
                showCursor: false,
                autofocus: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.none,
                textAlign: TextAlign.center,
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
                          .minAmountOnScreen(
                              int.parse(_myController.text),
                              Provider.of<AccountData>(context, listen: false)
                                  .accounts[index1],
                              Record(
                                  action: 2,
                                  name: Provider.of<AccountData>(context,
                                          listen: false)
                                      .accounts[index1]
                                      .name,
                                  amount: int.parse(_myController.text),
                                  dateTime:
                                      DateTime.now().millisecondsSinceEpoch),
                              Provider.of<AccountData>(context, listen: false)
                                  .expenses[index2],
                              snapshot,
                              index1);
                      // ignore: avoid_print
                      print(Provider.of<AccountData>(context, listen: false)
                          .accounts[index1]
                          .money);
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                  },
                  controller: _myController),
            ]),
          );
        });
  }
}
