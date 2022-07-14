import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/control_amount/add_amount.dart';
import 'package:project2/models/income.dart';
import 'package:project2/widgets/buttons/incomes_icon_button.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

class IncomeGridView extends StatelessWidget {
  final int index1;
  const IncomeGridView({
    Key? key,
    required this.index1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('income')
            .orderBy("dateTime")
            .snapshots(),
        builder: (context, snapshot) {
          return Consumer<AccountData>(builder: ((context, accountData, child) {
            List<Income> incomeList = accountData.incomes;

            if (snapshot.hasData) {
              final incomes = snapshot.data!.docs;

              if (incomeList.isEmpty) {
                if (incomeList.length < incomes.length) {
                  for (var income in incomes) {
                    final incomeRow = Income(
                        color: income['color'],
                        name: income['name'],
                        amount: income['amount'],
                        icon: income['icon'],
                        id: income['id'] ?? 'nothing',
                        dateTime: income['dateTime']);
                    incomeList.add(incomeRow);
                  }
                }
              }

              return GridView.builder(
                itemBuilder: (context, index2) {
                  return IncomesIconButton(
                    onLongPress: () =>
                        accountData.removeIncomeExpense(true, snapshot, index2),
                    onTap: () {
                      showModalBottomSheetMetod(
                          context,
                          AddAmount(
                            index2: index2,
                            index1: index1,
                          ));
                    },
                    index: index2,
                    income: incomeList[index2],
                  );
                },
                itemCount: accountData.incomes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 80,
                ),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const Center(child: Text('Please add some income category'));
          }));
        });
  }
}
