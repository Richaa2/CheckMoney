import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';

bool equal = true;

class NumPad2 extends StatelessWidget {
  final double buttonSize;

  final Color buttonColor;
  final Color iconColor;
  String userInput;
  final bool editNum;

  final void Function()? onSubmit;

  NumPad2({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = const Color.fromARGB(0, 158, 158, 158),
    this.iconColor = Colors.amber,
    this.userInput = '',
    this.editNum = false,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editNum == true
        ? userInput.contains('x') ||
            userInput.contains('+') ||
            userInput.contains('/')
        : userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('+') ||
            userInput.contains('/')) {
      equal = false;
    } else {
      equal = true;
    }
    var height;

    var width;
    Size size;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    Color? fnColor = const Color.fromARGB(255, 66, 66, 66);
    return WillPopScope(
      onWillPop: (() async {
        Provider.of<AccountData>(context, listen: false).userInput = '';
        return true;
      }),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(height / 40),
              alignment: Alignment.centerRight,
              child: Center(
                child: userInput.isEmpty
                    ? const Text(
                        '\$ 0',
                        style: TextStyle(fontSize: 30, color: Colors.teal),
                      )
                    : Text(
                        '\$ $userInput',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.teal,
                        ),
                      ),
              )),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              width: width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Spacer(
                    //   flex: 1,
                    // ),
                    Column(
                      children: [
                        FnButton(
                          fn: '/',
                          size: buttonSize,
                          color: fnColor,
                          onPressed: () {
                            if (equal == true && userInput != '0') {
                              userInput += '/';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('/');
                              equal = false;
                            }
                            if (equal == false) {}
                            if (userInput.endsWith('-') ||
                                userInput.endsWith('/') ||
                                userInput.endsWith('+') ||
                                userInput.endsWith('x')) {
                            } else if (userInput != '0') {
                              Provider.of<AccountData>(context, listen: false)
                                  .equalPressed();
                              userInput += '/';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('/');
                              equal = true;
                            }
                          },
                        ),
                        FnButton(
                          // bug with enter in empty userinput
                          fn: 'x',
                          size: buttonSize,
                          color: fnColor,
                          onPressed: () {
                            if (equal == false) {}

                            if (equal == true && userInput != '0') {
                              userInput += 'x';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('x');
                              equal = false;
                            }

                            if (userInput.endsWith('-') ||
                                userInput.endsWith('/') ||
                                userInput.endsWith('+') ||
                                userInput.endsWith('x')) {
                            } else if (userInput != '0') {
                              Provider.of<AccountData>(context, listen: false)
                                  .equalPressed();
                              userInput += 'x';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('x');
                              equal = true;
                            }
                          },
                        ),
                        FnButton(
                          fn: '-',
                          size: buttonSize,
                          color: fnColor,
                          onPressed: () {
                            if (equal == true && userInput != '0') {
                              userInput += '-';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('-');
                              equal = false;
                            }
                            if (equal == false) {}
                            if (userInput.endsWith('-') ||
                                userInput.endsWith('/') ||
                                userInput.endsWith('+') ||
                                userInput.endsWith('x')) {
                            } else if (userInput != '0') {
                              Provider.of<AccountData>(context, listen: false)
                                  .equalPressed();
                              userInput += '-';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('-');
                              equal = true;
                            }
                          },
                        ),
                        FnButton(
                          fn: '+',
                          size: buttonSize,
                          color: fnColor,
                          onPressed: () {
                            if (equal == true && userInput != '0') {
                              userInput += '+';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('+');
                              equal = false;
                            }
                            if (equal == false) {}
                            if (userInput.endsWith('-') ||
                                userInput.endsWith('/') ||
                                userInput.endsWith('+') ||
                                userInput.endsWith('x')) {
                            } else if (userInput != '0') {
                              Provider.of<AccountData>(context, listen: false)
                                  .equalPressed();
                              userInput += '+';
                              Provider.of<AccountData>(context, listen: false)
                                  .userInputs('+');
                              equal = true;
                            }
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
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Column(
                      children: [
                        DeleteButton(
                          iconData: Icons.backspace_rounded,
                          size: buttonSize,
                          color: fnColor,
                          sizeh: buttonSize,
                          onPressed: () {
                            Provider.of<AccountData>(context, listen: false)
                                .userDeleteInputs(false);
                          },
                        ),
                        DoneButton(
                            sizeh: buttonSize,
                            size: buttonSize,
                            color: Colors.teal,
                            onPressed: onSubmit),
                      ],
                    ),
                    // Spacer(
                    //   flex: 1,
                    // ),
                  ]),
            ),
          ),
        ],
      ),
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
      width: size * 1.1,
      height: size,
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

  final void Function()? onPressed;

  const FnButton(
      {Key? key,
      required this.fn,
      required this.size,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.1,
      height: size,
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

class DoneButton extends StatelessWidget {
  final double size;
  final double sizeh;
  final Color color;

  final void Function()? onPressed;
  final IconData iconData;

  const DoneButton({
    Key? key,
    required this.size,
    required this.color,
    this.onPressed,
    required this.sizeh,
    this.iconData = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.1,
      height: sizeh * 3,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Center(
          child: equal
              ? Icon(
                  iconData,
                  color: Colors.white,
                )
              : const Text(
                  '=',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final double size;
  final double sizeh;
  final Color color;

  final void Function()? onPressed;
  final IconData iconData;

  const DeleteButton({
    Key? key,
    required this.size,
    required this.color,
    this.onPressed,
    required this.sizeh,
    this.iconData = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.1,
      height: sizeh,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Center(
            child: Icon(
          iconData,
          color: Colors.white,
        )),
      ),
    );
  }
}
