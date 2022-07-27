import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/account_page/buttons/expenses_icon_button.dart';

import 'package:project2/control_amount/min_account.dart';
import 'package:project2/models/expense.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

class ExpenseGridView extends StatelessWidget {
  final int index1;
  const ExpenseGridView({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('expense')
            .orderBy("dateTime")
            .snapshots(),
        builder: (context, snapshot1) {
          return Consumer<AccountData>(
            builder: ((context, accountData, child) {
              List<Expense> expenseList = accountData.expenses;

              if (snapshot1.hasData) {
                final expenses = snapshot1.data!.docs;

                if (expenseList.isEmpty) {
                  if (expenseList.length < expenses.length) {
                    for (var expense in expenses) {
                      final expenseRow = Expense(
                          color: expense['color'],
                          name: expense['name'],
                          amount: expense['amount'],
                          icon: expense['icon'],
                          id: expense['id'] ?? 'nothing',
                          dateTime: expense['dateTime']);
                      expenseList.add(expenseRow);
                    }
                  }
                }

                return GridView.builder(
                  itemBuilder: (context, index2) {
                    final expensesAmount =
                        accountData.expenses[index2].amount.toInt();

                    return ExpensesIconButton(
                      onLongPress: () {
                        accountData.removeIncomeExpense(
                            false, snapshot1, index2);
                      },
                      onTap: () {
                        // ignore: avoid_print
                        print(expensesAmount);

                        showModalBottomSheetMetod(
                            context,
                            MinAmount(
                              index2: index2,
                              index1: index1,
                            ));
                      },
                      index: index2,
                      expense: expenseList[index2],
                    );
                  },
                  itemCount: accountData.expenses.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 80,
                  ),
                );
              }
              if (snapshot1.hasError) {
                print(snapshot1.error);
              }
              return const Center(child: Text('Please add some expense kind'));
            }),
          );
        });
  }
}
