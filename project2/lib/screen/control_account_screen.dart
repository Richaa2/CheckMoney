import 'package:flutter/material.dart';

import 'package:project2/control_amount/edit_amount.dart';
import 'package:project2/control_amount/min_account.dart';
import 'package:project2/models/account.dart';

import 'package:project2/screen/select_account_screen.dart';
import 'package:project2/screen/select_income_screen.dart';

import '../control_amount/add_amount.dart';
import '../widgets/buttons/ink_controll_button.dart';

class ControlAccountScreen extends StatelessWidget {
  const ControlAccountScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                index: index,
                color: Colors.green,
                icon: Icons.add,
                screen: SelectIncome(
                  index1: index,
                ),
                title: 'Recharge',
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                index: index,
                color: Colors.red,
                icon: Icons.remove,
                screen: MinAmount(
                  index: index,
                ),
                title: 'Withdraw',
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                index: index,
                color: Colors.yellow,
                icon: Icons.edit,
                screen: EditAmount(
                  index: index,
                ),
                title: 'Edit',
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                index: index,
                color: Colors.grey,
                icon: Icons.arrow_forward,
                screen: SelectAccount(
                  index1: index,
                ),
                title: 'Transfer',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final Account Function()? removeAcc;
  final Color color;
  final int index;
  final IconData icon;
  final Widget screen;
  final String title;
  const IconButton({
    Key? key,
    this.removeAcc,
    required this.color,
    required this.index,
    required this.icon,
    required this.screen,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkControllButton(
          removeAcc: removeAcc,
          index: index,
          color: color,
          icon: icon,
          screen: screen,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
