import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:project2/models/account_data.dart';
import 'package:project2/screen/account_screen.dart';
import 'package:project2/screen/history_screen.dart';

import 'package:provider/provider.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/drawer/drawer.dart';

int? sumOfAllAccount = 0;

class MainPage extends StatefulWidget {
  MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AccountScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser != null) {
      print(Provider.of<AccountData>(context).nameOfAccount);

      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('account')
              .snapshots(),
          builder: (context, snapshot) {
            var sum = Provider.of<AccountData>(context).sumOfAccounts();
            return Scaffold(
              drawer: const DrawerWidget(),
              appBar: AppBar(
                  title: Column(
                    children: [
                      Text(
                        'All account ',
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
    return Container();
  }
}
