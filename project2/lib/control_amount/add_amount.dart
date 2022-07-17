import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/models/history.dart';
import 'package:project2/widgets/num_pad.dart';
import 'package:project2/widgets/num_pad2.dart';

class AddAmount extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  final int index1;
  final int index2;
  AddAmount({Key? key, required this.index1, required this.index2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('userInfo')
            .snapshots(),
        builder: (context, snapshotInfo) {
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('income')
                  .snapshots(),
              builder: (context, snapshot) {
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('account')
                        .orderBy("q")
                        .snapshots(),
                    builder: (context, snapshot2) {
                      var user =
                          Provider.of<AccountData>(context, listen: false)
                              .userInput;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ContainerForNumPad(
                                    icon: Provider.of<AccountData>(context)
                                        .incomes[index2]
                                        .icon,
                                    name: Provider.of<AccountData>(context)
                                        .incomes[index2]
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
                                  if (user.endsWith('-') ||
                                      user.endsWith('/') ||
                                      user.endsWith('+') ||
                                      user.endsWith('x')) {
                                    Provider.of<AccountData>(context,
                                            listen: false)
                                        .userDeleteInputs(false);
                                  }
                                  if (user == '/' ||
                                      user == 'x' ||
                                      user == '+' ||
                                      user == '-') {
                                    Provider.of<AccountData>(context,
                                            listen: false)
                                        .userDeleteInputs(true);
                                    equal = true;
                                  } else {
                                    Provider.of<AccountData>(context,
                                            listen: false)
                                        .equalPressed();
                                    equal = true;
                                  }

                                  equal = true;
                                } else {
                                  if (Provider.of<AccountData>(context,
                                              listen: false)
                                          .userInput ==
                                      '') {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  } else {
                                    Provider.of<AccountData>(context,
                                            listen: false)
                                        .addAmountOnScreen(
                                            int.parse(Provider.of<AccountData>(
                                                    context,
                                                    listen: false)
                                                .userInput),
                                            Record(
                                              name: Provider.of<AccountData>(
                                                      context,
                                                      listen: false)
                                                  .accounts[index1]
                                                  .name,
                                              amount: int.parse(
                                                  Provider.of<AccountData>(
                                                          context,
                                                          listen: false)
                                                      .userInput),
                                              dateTime: DateTime.now()
                                                  .millisecondsSinceEpoch,
                                            ),
                                            snapshot,
                                            index1,
                                            index2,
                                            snapshot2,
                                            Provider.of<AccountData>(context,
                                                    listen: false)
                                                .sumUser,
                                            snapshotInfo);

                                    if (Provider.of<AccountData>(context,
                                                listen: false)
                                            .userInput !=
                                        '0') {
                                      Provider.of<AccountData>(context,
                                              listen: false)
                                          .userDeleteInputs(true);
                                    }
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  }
                                }
                              },
                              userInput: Provider.of<AccountData>(
                                context,
                              ).userInput,
                            ),
                          ],
                        ),
                      );
                    });
              });
        });
  }
}

class ContainerForNumPad extends StatelessWidget {
  final bool rightOrLeft;
  final String name;
  final String icon;
  const ContainerForNumPad({
    Key? key,
    required this.name,
    required this.icon,
    required this.rightOrLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        color: rightOrLeft == false ? Colors.teal[700] : Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 2,
                      child: rightOrLeft == false
                          ? const Text(
                              'From category',
                            )
                          : const Text('To account')),
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 5,
                child: rightOrLeft == false
                    ? CircleAvatar(
                        minRadius: 17.0,
                        maxRadius: 23.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          IconData(int.parse(icon),
                              fontFamily: 'MaterialIcons'),
                          color: Colors.teal[600],
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Icon(
                          IconData(int.parse(icon),
                              fontFamily: 'MaterialIcons'),
                          color: Colors.teal[600],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
