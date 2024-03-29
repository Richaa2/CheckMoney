import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/models/expense.dart';

import '../../models/income.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/list_tile_add_screen.dart';

// ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
//   fixedSize: const Size.fromHeight(50),
// );

class AddExpenseIncomeScreen extends StatefulWidget {
  final bool isExpense;
  AddExpenseIncomeScreen({
    Key? key,
    this.isExpense = false,
  }) : super(key: key);

  @override
  State<AddExpenseIncomeScreen> createState() => _AddExpenseIncomeScreenState();
}

class _AddExpenseIncomeScreenState extends State<AddExpenseIncomeScreen> {
  String name = 'without name';

  int money = 0;
  IconData? iconValue = Icons.credit_card;
  final List<IconData> icons = [
    Icons.paid,
    Icons.credit_card,
    Icons.attach_money,
    Icons.account_balance_wallet,
    Icons.savings,
    Icons.euro,
    Icons.money,
    Icons.currency_bitcoin,
  ];

  Color? valuee = Colors.blueGrey;
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.teal,
    Colors.indigo,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          decoration: BoxDecoration(color: valuee),
          child: AppBarContent(
            done: () {
              if (widget.isExpense == true) {
                Provider.of<AccountData>(context, listen: false).addExpense(
                    Expense(
                        name: name,
                        color: valuee!.value.toString(),
                        icon: iconValue!.codePoint.toString(),
                        amount: money,
                        dateTime: DateTime.now().millisecondsSinceEpoch,
                        id: 'UK'));
              } else {
                Provider.of<AccountData>(context, listen: false).addIncome(
                    Income(
                        name: name,
                        color: valuee!.value.toString(),
                        icon: iconValue!.codePoint.toString(),
                        amount: money,
                        dateTime: DateTime.now().millisecondsSinceEpoch,
                        id: 'UK'));
              }

              Navigator.popAndPushNamed(context, '/');
            },
            textField: TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Name', focusColor: Colors.white),
            ),
            acExIn: widget.isExpense == true ? 2 : 3,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(120, 71, 71, 71),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ListTile(
                      dense: true,
                      leading: Text(
                        'Style',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ListTileAddScreen(
                  title: 'Color',
                  subtitle: '',
                  trailing: DropdownButton<Color>(
                      value: valuee,
                      onChanged: (Color? newColor) {
                        setState(() {
                          valuee = newColor;
                        });
                      },
                      items: colors.map<DropdownMenuItem<Color>>((Color value) {
                        return DropdownMenuItem<Color>(
                          value: value,
                          child: Container(
                            width: 25,
                            height: 25,
                            color: value,
                          ),
                        );
                      }).toList()),
                ),
                const Divider(
                  height: 2,
                ),
                ListTileAddScreen(
                  title: 'Icon',
                  subtitle: '',
                  trailing: DropdownButton<IconData>(
                      value: iconValue,
                      onChanged: (IconData? newIcon) {
                        setState(() {
                          iconValue = newIcon;
                        });
                      },
                      items: icons
                          .map<DropdownMenuItem<IconData>>((IconData value) {
                        return DropdownMenuItem<IconData>(
                          value: value,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Icon(value),
                          ),
                        );
                      }).toList()),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(120, 71, 71, 71),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
