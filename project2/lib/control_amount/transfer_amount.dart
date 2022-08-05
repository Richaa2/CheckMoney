import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/main_page.dart';

import 'package:provider/provider.dart';

import '../models/account_data.dart';
import '../models/history.dart';
import 'container_for_numpad.dart';
import 'num_pad.dart';

class TransferAmount extends StatelessWidget {
  final int index1;
  final int index2;
  const TransferAmount({
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
            .collection('account')
            .snapshots(),
        builder: (context, snapshot) {
          var user = Provider.of<AccountData>(context, listen: false).userInput;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: ContainerForNumPad(
                      icon: Provider.of<AccountData>(context)
                          .accounts[index1]
                          .icon,
                      name: Provider.of<AccountData>(context)
                          .accounts[index1]
                          .name,
                      rightOrLeft: false,
                      editOrTransfer: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ContainerForNumPad(
                      icon: Provider.of<AccountData>(context)
                          .accounts[index2]
                          .icon,
                      name: Provider.of<AccountData>(context)
                          .accounts[index2]
                          .name,
                      rightOrLeft: true,
                      editOrTransfer: false,
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
                    if (user.endsWith('-') ||
                        user.endsWith('/') ||
                        user.endsWith('+') ||
                        user.endsWith('x')) {
                      Provider.of<AccountData>(context, listen: false)
                          .userDeleteInputs(false);
                    }
                    if (user == '/' ||
                        user == 'x' ||
                        user == '+' ||
                        user == '-') {
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
                    if (Provider.of<AccountData>(context, listen: false)
                            .userInput ==
                        '') {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      Provider.of<AccountData>(context, listen: false)
                          .transferAmountOnScreen(
                              int.parse(Provider.of<AccountData>(context,
                                      listen: false)
                                  .userInput),
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
                                amount: int.parse(Provider.of<AccountData>(
                                        context,
                                        listen: false)
                                    .userInput),
                                dateTime: DateTime.now().millisecondsSinceEpoch,
                                icon: Provider.of<AccountData>(context,
                                        listen: false)
                                    .accounts[index2]
                                    .icon,
                                color: Provider.of<AccountData>(context,
                                        listen: false)
                                    .accounts[index2]
                                    .colorValue,
                                subName: Provider.of<AccountData>(context,
                                        listen: false)
                                    .accounts[index1]
                                    .name,
                                icon2: Provider.of<AccountData>(context,
                                        listen: false)
                                    .accounts[index1]
                                    .icon,
                              ),
                              snapshot,
                              index1,
                              index2);
                      if (Provider.of<AccountData>(context, listen: false)
                              .userInput !=
                          '0') {
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
            ],
          );
        });
  }
}
