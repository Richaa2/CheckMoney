import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project2/widgets/num_pad2.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';

import '../widgets/container_for_numpad.dart';

class EditAmount extends StatelessWidget {
  final int index;
  const EditAmount({
    Key? key,
    required this.index,
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
          String init = Provider.of<AccountData>(
                context,
              ).userInput +
              Provider.of<AccountData>(
                context,
              ).accounts[index].money.toString();

          var user = Provider.of<AccountData>(
            context,
          ).userInput;
          if (Provider.of<AccountData>(
                context,
              ).userInput ==
              '') {
            Provider.of<AccountData>(
              context,
            ).userInput = init + user;
          }
          // user = init + user;
          // user = Provider.of<AccountData>(
          //   context,
          // ).accounts[index].money.toString();
          if (user.length > init.length) {
            user = user +
                Provider.of<AccountData>(
                  context,
                ).userInput;
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ContainerForNumPad(
                      icon: Provider.of<AccountData>(context)
                          .accounts[index]
                          .icon,
                      name: Provider.of<AccountData>(context)
                          .accounts[index]
                          .name,
                      editOrTransfer: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              NumPad2(
                editNum: true,
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
                    if (user == '') {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    } else {
                      Provider.of<AccountData>(context, listen: false)
                          .editAmountOnScreen(
                              int.parse(Provider.of<AccountData>(context,
                                      listen: false)
                                  .userInput),
                              snapshot,
                              index);
                      if (Provider.of<AccountData>(context, listen: false)
                              .userInput !=
                          '0') {
                        Provider.of<AccountData>(context, listen: false)
                            .userDeleteInputs(true);
                      }
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                  }
                },
                userInput: user,
              ),
            ],
          );
        });
  }
}
