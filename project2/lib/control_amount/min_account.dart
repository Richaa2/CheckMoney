import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:project2/control_amount/num_pad.dart';
import 'package:project2/main_page.dart';

import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../models/history.dart';

import 'container_for_numpad.dart';

class MinAmount extends StatelessWidget {
  final int index1;
  final int index2;
  const MinAmount({
    Key? key,
    required this.index1,
    required this.index2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('expense')
            .snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .collection('account')
                  .orderBy("q")
                  .snapshots(),
              builder: (context, snapshot2) {
                var userInput =
                    Provider.of<AccountData>(context, listen: false).userInput;
                return Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ContainerForNumPad(
                          icon: Provider.of<AccountData>(context)
                              .expenses[index2]
                              .icon,
                          name: Provider.of<AccountData>(context)
                              .expenses[index2]
                              .name,
                          rightOrLeft: false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ContainerForNumPad(
                          icon: Provider.of<AccountData>(context)
                              .accounts[index1]
                              .icon,
                          name: Provider.of<AccountData>(context)
                              .accounts[index1]
                              .name,
                          rightOrLeft: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NumPad2(
                    onSubmit: () {
                      if (equal == false) {
                        if (userInput.endsWith('-') ||
                            userInput.endsWith('/') ||
                            userInput.endsWith('+') ||
                            userInput.endsWith('x')) {
                          Provider.of<AccountData>(context, listen: false)
                              .userDeleteInputs(false);
                        }
                        if (userInput == '/' ||
                            userInput == 'x' ||
                            userInput == '+' ||
                            userInput == '-') {
                          Provider.of<AccountData>(context, listen: false)
                              .userDeleteInputs(true);
                          equal = true;
                        } else {
                          Provider.of<AccountData>(context, listen: false)
                              .equalPressed();
                          equal = true;
                        }

                        equal = true;
                      } else {
                        if (userInput == '') {
                          Navigator.pushReplacementNamed(context, '/');
                        } else {
                          Provider.of<AccountData>(context, listen: false)
                              .minAmountOnScreen(
                            int.parse(userInput),
                            Provider.of<AccountData>(context, listen: false)
                                .accounts[index1],
                            Record(
                              action: 2,
                              name: Provider.of<AccountData>(context,
                                      listen: false)
                                  .expenses[index2]
                                  .name,
                              amount: int.parse(userInput),
                              dateTime: DateTime.now().millisecondsSinceEpoch,
                              icon: Provider.of<AccountData>(context,
                                      listen: false)
                                  .expenses[index2]
                                  .icon,
                              color: Provider.of<AccountData>(context,
                                      listen: false)
                                  .expenses[index2]
                                  .color,
                              subName: Provider.of<AccountData>(context,
                                      listen: false)
                                  .accounts[index1]
                                  .name,
                              icon2: Provider.of<AccountData>(context,
                                      listen: false)
                                  .accounts[index1]
                                  .icon,
                            ),
                            Provider.of<AccountData>(context, listen: false)
                                .expenses[index2],
                            snapshot,
                            index1,
                            index2,
                            snapshot2,
                          );
                          if (userInput != '0') {
                            Provider.of<AccountData>(context, listen: false)
                                .userDeleteInputs(true);
                          }
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      }
                    },
                    userInput: Provider.of<AccountData>(
                      context,
                    ).userInput,
                  ),
                ]);
              });
        });
  }
}
