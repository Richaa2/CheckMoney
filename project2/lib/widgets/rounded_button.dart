import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String nameOfButton;
  final Color colorOfButton;
  final void Function() onPress;
  RoundedButton({
    required this.nameOfButton,
    required this.colorOfButton,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colorOfButton,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            nameOfButton,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
