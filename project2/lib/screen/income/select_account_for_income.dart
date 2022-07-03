import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project2/models/account_data.dart';

import 'account_list_for_expense.dart';

class SelectAccountForIncome extends StatelessWidget {
  final int index1;
  const SelectAccountForIncome({
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
              child: AccountsListViewIncome(
                index1: index1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
