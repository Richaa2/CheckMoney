import 'package:flutter/material.dart';

import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

bool equal = true;

class NumPad2 extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  late final String userInput;

  final void Function()? onSubmit;

  NumPad2({
    Key? key,
    this.buttonSize = 80,
    this.buttonColor = const Color.fromARGB(0, 158, 158, 158),
    this.iconColor = Colors.amber,
    required this.onSubmit,
    this.userInput = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userInput.contains('-') ||
        userInput.contains('x') ||
        userInput.contains('+') ||
        userInput.contains('/')) {
      equal = false;
    } else {
      equal = true;
    }

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
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              FnButton(
                fn: '/',
                size: buttonSize,
                color: fnColor,
                onPressed: () {
                  if (equal == true) {
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
                  } else {
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
                fn: 'x',
                size: buttonSize,
                color: fnColor,
                onPressed: () {
                  if (equal == true) {
                    userInput += 'x';
                    Provider.of<AccountData>(context, listen: false)
                        .userInputs('x');
                    equal = false;
                  }
                  if (equal == false) {}
                  if (userInput.endsWith('-') ||
                      userInput.endsWith('/') ||
                      userInput.endsWith('+') ||
                      userInput.endsWith('x')) {
                  } else {
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
                  if (equal == true) {
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
                  } else {
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
                  if (equal == true) {
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
                  } else {
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

          Column(
            children: [
              DeleteButton(
                iconData: Icons.backspace_rounded,
                size: buttonSize,
                color: fnColor,
                sizeh: buttonSize - 5,
                onPressed: () {
                  Provider.of<AccountData>(context, listen: false)
                      .userDeleteInputs(false);
                },
              ),
              DoneButton(
                  sizeh: buttonSize + 123,
                  size: buttonSize,
                  color: Colors.teal,
                  onPressed: onSubmit)
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

class DoneButton extends StatelessWidget {
  final double size;
  final double sizeh;
  final Color color;

  void Function()? onPressed;
  final IconData iconData;

  DoneButton({
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

class DeleteButton extends StatelessWidget {
  final double size;
  final double sizeh;
  final Color color;

  void Function()? onPressed;
  final IconData iconData;

  DeleteButton({
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
      width: size,
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
