import 'package:flutter/material.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/screen/account_screen.dart';
import 'package:project2/screen/history_screen.dart';

import 'package:project2/widgets/accounts_list.dart';
import 'package:provider/provider.dart';

import '../widgets/build_item.dart';
import '../widgets/drawer.dart';
import '../widgets/showModalBottomSheetMetod.dart';
import 'add_account_screen.dart';
import 'expenses_screen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    AccountScreen(),
    ExpensesScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sum = Provider.of<AccountData>(context).sumOfAccounts();
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
          title: Column(
            children: [
              Text(
                'All account',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                '\$$sum',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,

          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheetMetod(context, AddAccountScreen());
              },
            ),
          ]),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Accounts',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined),
              label: 'Categories',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'History',
              backgroundColor: Colors.white),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
