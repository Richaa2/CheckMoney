import 'package:flutter/material.dart';
import 'package:project2/account_page/buttons/ink_controll_button.dart';
import 'package:project2/account_page/select_account_screen.dart';
import 'package:project2/account_page/select_ex_inc/select_expense_income_screen.dart';

import 'package:project2/control_amount/edit_amount.dart';
import 'package:project2/models/account.dart';

class ControlAccountScreen extends StatelessWidget {
  const ControlAccountScreen({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size;
    size = MediaQuery.of(context).size;
    var height = size.height;

    return SizedBox(
      height: height / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(
                flex: 4,
              ),
              IconButton(
                index: index,
                color: Colors.green,
                icon: Icons.add,
                screen: SelectExpenseIncome(
                  index1: index,
                  isExpense: false,
                ),
                title: 'Recharge',
              ),
              const Spacer(
                flex: 2,
              ),
              IconButton(
                index: index,
                color: Colors.red,
                icon: Icons.remove,
                screen: SelectExpenseIncome(
                  index1: index,
                  isExpense: true,
                ),
                title: 'Withdraw',
              ),
              const Spacer(
                flex: 2,
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
              const Spacer(
                flex: 2,
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
              const Spacer(
                flex: 4,
              ),
            ],
          ),
          const Spacer(
            flex: 1,
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
