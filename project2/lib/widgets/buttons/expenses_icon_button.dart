import 'package:flutter/material.dart';

class ExpensesIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int amount;
  const ExpensesIconButton(
      {super.key,
      required this.icon,
      required this.color,
      required this.title,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    // if (title = ''){
    //   return SizedBox(height: 10,)
    // }
    if (title == '') {
      return const SizedBox(
        width: 60,
        height: 120,
      );
    }
    return SizedBox(
      width: 60,
      height: 120,
      child: Column(
        children: [
          Text(title),
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundColor: color,
            child: IconButton(
              onPressed: () {},
              icon: Icon(icon),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('$amount'),
        ],
      ),
    );
  }
}
