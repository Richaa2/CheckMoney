import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:project2/screen/account_screen.dart';
import 'package:project2/screen/history_screen.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/drawer/drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AccountScreen(),
    const HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser != null) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('userInfo')
              .snapshots(),
          builder: (context, snapshot) {
            var sum = 0;

            if (snapshot.hasData) {
              sum = snapshot.data!.docs.single['sum'];
              print('suka');
            }
            return Scaffold(
              body: PersistentTabView(
                context,
                backgroundColor: Colors.black.withOpacity(0.0),
                controller: _controller,
                screens: _screens,
                items: [
                  PersistentBottomNavBarItem(
                      icon: Icon(Icons.credit_card),
                      title: 'Accounts',
                      inactiveColorPrimary: Colors.grey,
                      activeColorPrimary: Colors.teal),
                  PersistentBottomNavBarItem(
                      icon: Icon(Icons.receipt),
                      title: 'History',
                      inactiveColorPrimary: Colors.grey,
                      activeColorPrimary: Colors.teal),
                ],
                confineInSafeArea: true,
                decoration: NavBarDecoration(
                  // borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.blueGrey.withOpacity(0.1),
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style1,
              ),
              drawer: const DrawerWidget(),
              appBar: AppBar(
                  title: Column(
                    children: [
                      const Text(
                        'All account ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '\$$sum',
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
            );
          });
    }
    return Container();
  }
}
