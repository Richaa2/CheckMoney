import 'package:flutter/material.dart';

import '../../widgets/expense_grid_view.dart';

class SelectExpense extends StatelessWidget {
  final int index1;
  const SelectExpense({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Expense',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ExpenseGridView(
                index1: index1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
