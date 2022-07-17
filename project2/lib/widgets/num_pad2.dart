import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/utils.dart';
import 'package:provider/provider.dart';

import '../control_amount/add_amount.dart';
import '../models/history.dart';

bool equal = true;

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad2 extends StatelessWidget {
  final int index1;
  final int index2;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot2;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshotInfo;
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final void Function()? delete;
  final void Function()? onSubmit;

  const NumPad2({
    Key? key,
    this.buttonSize = 80,
    this.buttonColor = const Color.fromARGB(0, 158, 158, 158),
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
    required this.index1,
    required this.index2,
    required this.snapshot,
    required this.snapshot2,
    required this.snapshotInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInput = Provider.of<AccountData>(
      context,
    ).userInput;

    Color? fnColor = Color.fromARGB(255, 66, 66, 66);
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Center(
              child: userInput.isEmpty
                  ? Text(
                      '\$ 0',
                      style: TextStyle(fontSize: 30, color: Colors.teal),
                    )
                  : Text(
                      '\$ $userInput',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.teal,
                      ),
                    ),
            )),
        Container(
            // margin: const EdgeInsets.only(left: 5, right: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Column(
                // implement the number keys (from 0 to 9) with the NumberButton widget
                // the NumberButton widget is defined in the bottom of this file
                children: [
                  FnButton(
                    fn: '/',
                    size: buttonSize,
                    color: fnColor,
                    controller: controller,
                    onPressed: () {
                      userInput += '/';
                      Provider.of<AccountData>(context, listen: false)
                          .userInputs('/');
                      equal = false;
                    },
                  ),
                  FnButton(
                    fn: 'x',
                    size: buttonSize,
                    color: fnColor,
                    controller: controller,
                    onPressed: () {
                      userInput += 'x';
                      Provider.of<AccountData>(context, listen: false)
                          .userInputs('x');
                      equal = false;
                    },
                  ),
                  FnButton(
                    fn: '-',
                    size: buttonSize,
                    color: fnColor,
                    controller: controller,
                    onPressed: () {
                      userInput += '-';
                      Provider.of<AccountData>(context, listen: false)
                          .userInputs('-');
                      equal = false;
                    },
                  ),
                  FnButton(
                    fn: '+',
                    size: buttonSize,
                    color: fnColor,
                    controller: controller,
                    onPressed: () {
                      userInput += '+';
                      Provider.of<AccountData>(context, listen: false)
                          .userInputs('+');
                      equal = false;

                      print(equal);
                    },
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              Column(
                children: [
                  NumberButton(
                    number: 7,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 4,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 1,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  FnButton(
                    fn: '\$',
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                children: [
                  NumberButton(
                    number: 8,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 5,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 2,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 0,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              Column(
                children: [
                  NumberButton(
                    number: 9,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 6,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  NumberButton(
                    number: 3,
                    size: buttonSize,
                    color: buttonColor,
                  ),
                  FnButton(
                    onPressed: () {},
                    fn: '',
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                  ),
                  // SizedBox(
                  //   width: buttonSize,
                  //   height: buttonSize - 10,
                  // )
                ],
              ),
              // const SizedBox(height: 20),
              Column(
                children: [
                  DoneButton(
                    iconData: Icons.backspace_rounded,
                    size: buttonSize,
                    color: fnColor,
                    controller: controller,
                    sizeh: buttonSize - 5,
                    onPressed: () {
                      if (userInput == '0' || userInput == '') {}
                      if (userInput != '0' || userInput != '') {
                        Provider.of<AccountData>(context, listen: false)
                            .userDeleteInputs(false);
                      }
                    },
                  ),
                  // this button is used to delete the last number
                  // SizedBox(
                  //   width: buttonSize,
                  //   height: buttonSize - 10,
                  // ),
                  // this button is used to submit the entered value

                  DoneButton(
                      sizeh: buttonSize + 123,
                      size: buttonSize,
                      color: Colors.teal,
                      controller: controller,
                      onPressed: () {
                        if (equal == false) {
                          Provider.of<AccountData>(context, listen: false)
                              .equalPressed();
                          equal = true;
                        } else {
                          if (Provider.of<AccountData>(context, listen: false)
                                  .userInput ==
                              '') {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          } else {
                            Provider.of<AccountData>(context, listen: false)
                                .addAmountOnScreen(
                                    int.parse(Provider.of<AccountData>(context,
                                            listen: false)
                                        .userInput),
                                    // Provider.of<AccountData>(context,
                                    //         listen: false)
                                    //     .accounts[index1],
                                    Record(
                                      name: Provider.of<AccountData>(context,
                                              listen: false)
                                          .accounts[index1]
                                          .name,
                                      amount: int.parse(userInput),
                                      dateTime:
                                          DateTime.now().millisecondsSinceEpoch,
                                    ),
                                    // Provider.of<AccountData>(context,
                                    //         listen: false)
                                    //     .incomes[index2],
                                    snapshot,
                                    index1,
                                    index2,
                                    snapshot2,
                                    Provider.of<AccountData>(context,
                                            listen: false)
                                        .sumUser,
                                    snapshotInfo);

                            // if (userInput != '0') {
                            //   Provider.of<AccountData>(context, listen: false)
                            //       .userDeleteInputs(true);
                            // }
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          }
                        }
                      }),
                ],
              )
            ])),
      ],
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size - 10,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          Provider.of<AccountData>(context, listen: false)
              .userInputs(number.toString());
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.grey,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class FnButton extends StatelessWidget {
  final String fn;
  final double size;
  final Color color;
  final TextEditingController controller;
  final void Function()? onPressed;

  const FnButton(
      {Key? key,
      required this.fn,
      required this.size,
      required this.color,
      required this.controller,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size - 10,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Center(
          child: Text(
            fn,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.grey,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

// function to calculate the input operation
// void equalPressed(String userInput) {
//   String finaluserinput = userInput;
//   finaluserinput = userInput.replaceAll('x', '*');

//   Parser p = Parser();
//   Expression exp = p.parse(finaluserinput);
//   ContextModel cm = ContextModel();
//   num eval = exp.evaluate(EvaluationType.REAL, cm);

//   userInput = eval.toString();
// }

class DoneButton extends StatelessWidget {
  final double size;
  final double sizeh;
  final Color color;
  final TextEditingController controller;
  void Function()? onPressed;
  final IconData iconData;

  DoneButton({
    Key? key,
    required this.size,
    required this.color,
    required this.controller,
    this.onPressed,
    required this.sizeh,
    this.iconData = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: sizeh,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Center(
          child: equal
              ? Icon(
                  iconData,
                  color: Colors.white,
                )
              : Text(
                  '=',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
