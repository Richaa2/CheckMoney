import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';

import '../widgets/num_pad.dart';
import 'add_account_balance.dart';

ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: Size.fromHeight(50),
);

class AddAccountScreen extends StatefulWidget {
  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  TextEditingController _myController = TextEditingController();
  String name = 'without name';

  int money = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, accountData) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.blueGrey),
                child: AppBarContent(
                  done: () {
                    Provider.of<AccountData>(context, listen: false)
                        .addAccount(Account(name: name, money: money));
                    Navigator.pop(context);
                  },
                  textField: TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Name', focusColor: Colors.white),
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(120, 71, 71, 71),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ListTile(
                            dense: true,
                            leading: Text(
                              'Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
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
                      ),
                      Divider(
                        height: 2,
                      ),
                      ListTileAccountAdd(
                          title: 'Account currency',
                          subtitle: 'Ukranian hryvnian - \$'),
                      Divider(
                        height: 3,
                      ),
                      ListTileAccountAdd(
                        title: 'Description',
                        subtitle: 'none',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(120, 71, 71, 71),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ListTile(
                            dense: true,
                            leading: Text(
                              'Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
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
                                inputMoney: money,
                                NumPad: NumPad(
                                    delete: () {
                                      if (_myController.text.isEmpty) {
                                      } else {
                                        _myController.text = _myController.text
                                            .substring(0,
                                                _myController.text.length - 1);
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
                                TextField: TextField(
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
                        leading: Text(
                          'Account balance',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          '$money\$',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        leading: Text(
                          'Credit limit',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          '0\$',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                          leading: Text(
                            'Include in total balance',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          trailing: Switch(
                            onChanged: (value) {
                              value = !value;
                            },
                            value: true,
                          )),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class ListTileAccountAdd extends StatelessWidget {
  final String title;
  final String subtitle;

  const ListTileAccountAdd({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  final void Function() done;
  // String inputName = 'without name';
  // int inputMoney = 0;
  Widget textField;

  AppBarContent({
    Key? key,
    required this.done,
    required this.textField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'New account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    Icons.check,
                    size: 20,
                  ),
                  color: Colors.white,
                  onPressed: done),
            ],
          ),
        ),
        Row(
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 15,
              child: SizedBox(child: textField),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}

// body: Container(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Add Account',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.lightBlueAccent,
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: 100,
//                         child: Column(
//                           children: [
//                             Text('Name'),
//                             TextField(
//                               onChanged: (nameText) {
//                                 inputName = nameText;
//                               },
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         width: 100,
//                         child: Column(
//                           children: [
//                             Text('Amount'),
//                             TextField(
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              // keyboardType: TextInputType.number,
                              // onChanged: (moneyAm) {
                              //   inputMoney = int.parse(moneyAm);
                              // },
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   style: raisedButtonStyle,
//                   onPressed: () {
//                     Provider.of<AccountData>(context, listen: false).addAccount(
//                         Account(name: inputName, money: inputMoney));

//                     Navigator.pop(context);
//                   },
//                   child: Text('Add'))
//             ],
//           ),
//         ),
//       ),
