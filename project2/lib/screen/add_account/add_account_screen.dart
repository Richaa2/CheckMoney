import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

import '../../widgets/accounts_widgets/app_bar_content.dart';
import '../../widgets/accounts_widgets/list_tile_account_add.dart';
import '../../widgets/num_pad.dart';
import 'add_account_balance.dart';

ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size.fromHeight(50),
);

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController _myController = TextEditingController();
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
              // Provider.of<AccountData>(context, listen: false)
              //     .addAccountFirebase(
              //   name,
              //   valuee!.value.toString(),
              //   iconValue!.codePoint.toString(),
              //   money,
              // );
              Provider.of<AccountData>(context, listen: false).addAccount(
                Account(
                    colorValue: valuee!.value.toString(),
                    name: name,
                    money: money,
                    icon: iconValue!.codePoint.toString(),
                    id: 'b'),
              );

              Navigator.popAndPushNamed(context, '/');
            },
            textField: TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Name', focusColor: Colors.white),
            ),
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
                        'Account',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ListTileAccountAdd(
                  title: 'Type',
                  subtitle: 'Regular',
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
                ListTileAccountAdd(
                  title: 'Account currency',
                  subtitle: 'Ukranian hryvnian - \$',
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
                const Divider(
                  height: 3,
                ),
                const ListTileAccountAdd(
                  title: 'Description',
                  subtitle: 'none',
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
                        'Balance',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showModalBottomSheetMetod(
                        context,
                        AddAccountBalance(
                          numPad: NumPad(
                              delete: () {
                                if (_myController.text.isEmpty) {
                                } else {
                                  _myController.text = _myController.text
                                      .substring(
                                          0, _myController.text.length - 1);
                                }
                              },
                              onSubmit: () {
                                setState(() {
                                  if (_myController.text.isEmpty) {
                                    Navigator.pop(context);
                                  } else {
                                    money = int.parse(_myController.text);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              controller: _myController),
                          textField: TextField(
                            controller: _myController,
                            showCursor: false,
                            autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.none,
                            textAlign: TextAlign.center,
                          ),
                        ));
                  },
                  leading: const Text(
                    'Account balance',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  trailing: Text(
                    '$money\$',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                const ListTile(
                  leading: Text(
                    'Credit limit',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  trailing: Text(
                    '0\$',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  leading: const Text(
                    'Include in total balance',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  trailing: Switch(
                    onChanged: (value) {
                      value = !value;
                    },
                    value: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
