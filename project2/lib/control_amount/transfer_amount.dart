import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project2/widgets/num_pad.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../models/history.dart';

class TransferAmount extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  final int index1;
  final int index2;
  TransferAmount({
    Key? key,
    required this.index1,
    required this.index2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('account')
            .snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Column(
              children: [
                const Text('Transfer amount'),
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
                            .transferAmountOnScreen(
                                int.parse(_myController.text),
                                Provider.of<AccountData>(context, listen: false)
                                    .accounts[index1],
                                Provider.of<AccountData>(context, listen: false)
                                    .accounts[index2],
                                Record(
                                    action: 3,
                                    name: Provider.of<AccountData>(context,
                                            listen: false)
                                        .accounts[index2]
                                        .name,
                                    amount: int.parse(_myController.text),
                                    dateTime:
                                        DateTime.now().millisecondsSinceEpoch),
                                snapshot,
                                index1,
                                index2);
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
        });
  }
}
