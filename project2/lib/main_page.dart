import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:project2/history_page/history_screen.dart';
import 'package:project2/reg/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'account_page/account_screen.dart';
import 'models/account_data.dart';
import 'widgets/dialog_widget.dart';
import 'widgets/drawer/drawer.dart';

FirebaseApp secondaryApp = Firebase.app('CheckMoney3');
FirebaseFirestore db = FirebaseFirestore.instanceFor(app: secondaryApp);

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

final auth = FirebaseAuth.instanceFor(app: secondaryApp);

class _MainPageState extends State<MainPage> {
  User? loggedInUser = FirebaseAuth.instanceFor(app: secondaryApp).currentUser;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // void getCurrentUser() async {
  //   try {
  //     final user  = auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  int selectedIndex = 0;

  final List<Widget> _screens = [
    const AccountScreen(),
    const HistoryScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // auth.signOut();
    if (loggedInUser == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
    if (loggedInUser != null) {
      String uid = loggedInUser!.uid;

      return WillPopScope(
        onWillPop: () async {
          Provider.of<AccountData>(context, listen: false).userInput = '';
          return true;
        },
        child: Scaffold(
          body: PersistentTabView(
            context,
            backgroundColor: Colors.black.withOpacity(0.0),
            controller: _controller,
            screens: _screens,
            items: [
              PersistentBottomNavBarItem(
                  icon: const Icon(Icons.credit_card),
                  title: 'Accounts',
                  inactiveColorPrimary: Colors.grey,
                  activeColorPrimary: Colors.teal),
              PersistentBottomNavBarItem(
                  icon: const Icon(Icons.receipt),
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
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style1,
          ),
          drawer: const DrawerWidget(),
          appBar: AppBar(
              title: StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('users')
                      .doc(uid)
                      .collection('userInfo')
                      .snapshots(),
                  builder: (context, snapshot) {
                    var sum = 0;
                    if (snapshot.hasData) {
                      sum = snapshot.data!.docs.single['sum'];
                    }
                    return Column(
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
                    );
                  }),
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
        ),
      );
      // });
    }
    return Container();
  }
}
