import 'package:flutter/material.dart';

class IncomesIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int amount;
  final void Function()? onTap;
  const IncomesIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: onTap,
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
