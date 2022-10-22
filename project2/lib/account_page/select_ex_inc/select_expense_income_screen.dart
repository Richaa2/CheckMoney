import 'package:flutter/material.dart';
import 'package:project2/account_page/gridview/income_grid_view.dart';

import '../gridview/expense_grid_view.dart';

class SelectExpenseIncome extends StatelessWidget {
  final bool isExpense;
  final int index1;
  const SelectExpenseIncome({
    Key? key,
    this.isExpense = false,
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
              children: [
                Text(
                  isExpense ? 'Expenses' : 'Incomes',
                  style: const TextStyle(
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
              child: isExpense
                  ? ExpenseGridView(
                      index1: index1,
                    )
                  : IncomeGridView(index1: index1),
            ),
          ],
        ),
      ),
    );
  }
}
