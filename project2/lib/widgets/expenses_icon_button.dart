import 'package:flutter/material.dart';

class ExpensesIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int amount;
  ExpensesIconButton(
      {super.key,
      required this.icon,
      required this.color,
      required this.title,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 10,
        ),
        CircleAvatar(
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon),
            color: Colors.white,
          ),
          backgroundColor: color,
        ),
        SizedBox(
          height: 10,
        ),
        Text('$amount'),
      ],
    );
  }
}
