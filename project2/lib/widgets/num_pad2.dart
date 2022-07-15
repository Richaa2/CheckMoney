import 'package:flutter/material.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad2 extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad2({
    Key? key,
    this.buttonSize = 82,
    this.buttonColor = const Color.fromARGB(0, 158, 158, 158),
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? fnColor = Color.fromARGB(255, 66, 66, 66);
    return Container(
        // margin: const EdgeInsets.only(left: 5, right: 5),
        child: Column(children: [
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // implement the number keys (from 0 to 9) with the NumberButton widget
        // the NumberButton widget is defined in the bottom of this file
        children: [
          FnButton(
            fn: '%',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
          NumberButton(
            number: 1,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 2,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 3,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          FnButton(
            fn: '+',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
        ],
      ),
      // const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FnButton(
            fn: 'x',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
          NumberButton(
            number: 4,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 5,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 6,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          FnButton(
            fn: '+',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
        ],
      ),
      // const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FnButton(
            fn: '-',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
          NumberButton(
            number: 7,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 8,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 9,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          FnButton(
            fn: '+',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
        ],
      ),
      // const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FnButton(
            fn: '+',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
          // this button is used to delete the last number
          NumberButton(
            number: 0,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          NumberButton(
            number: 0,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          // this button is used to submit the entered value
          NumberButton(
            number: 0,
            size: buttonSize,
            color: buttonColor,
            controller: controller,
          ),
          FnButton(
            fn: '+',
            size: buttonSize,
            color: fnColor,
            controller: controller,
          ),
        ],
      )
    ]));
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          controller.text += number.toString();
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

  const FnButton({
    Key? key,
    required this.fn,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          controller.text += fn.toString();
        },
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
