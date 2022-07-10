import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/screen/account_screen.dart';
import 'package:project2/screen/history_screen.dart';

import 'package:provider/provider.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/drawer.dart';

class MainPage extends StatefulWidget {
  MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AccountScreen(),
    const HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('account')
            .orderBy("q")
            .snapshots(),
        builder: (context, snapshot) {
          var sum =
              Provider.of<AccountData>(context, listen: true).sumOfAccounts();
          return Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppBar(
                title: Column(
                  children: [
                    const Text(
                      'All account',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '\$${sum}',
                      style: const TextStyle(
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
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/addAcc');
                      showDialog(
                          context: context,
                          builder: (context) => const DialogWidget());
                    },
                  ),
                ]),
            body: _screens.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card),
                    label: 'Accounts',
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
        });
  }
}
