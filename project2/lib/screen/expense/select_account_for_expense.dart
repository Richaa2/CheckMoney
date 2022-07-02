import 'package:flutter/material.dart';
import 'package:project2/screen/expense/account_list_for_expense.dart';
import 'package:provider/provider.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/accounts_widgets/account_list_view2.dart';

class SelectAccountForExpense extends StatelessWidget {
  final int index1;
  const SelectAccountForExpense({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Accounts',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '$sum ',
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: AccountsListViewExpense(
                index1: index1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
