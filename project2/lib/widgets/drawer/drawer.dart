import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/reg/welcome_screen.dart';
import 'package:project2/widgets/drawer/set_name.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    String name = 'name';
    String inputName = '';
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('userInfo')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.single['name'] == null) {
              snapshot.data!.docs.single['name'] == 'name';
            } else {
              name = snapshot.data!.docs.single['name'];
            }
          }
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 65, 175, 133),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${FirebaseAuth.instance.currentUser!.email}'),
                      Text(name),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.input),
                  title: const Text('Name'),
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (context) => SetName(
                              onChanged: (value) {
                                inputName = value;
                              },
                              onPressed: () {
                                Provider.of<AccountData>(context, listen: false)
                                    .updateNameOfAccount(
                                        inputName,
                                        snapshot,
                                        Provider.of<AccountData>(context,
                                                listen: false)
                                            .sumUser);
                                Navigator.pop(context);
                              },
                            ))
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.verified_user),
                //   title: const Text('Profile'),
                //   onTap: () => {Navigator.of(context).pop()},
                // ),
                // ListTile(
                //   leading: const Icon(Icons.settings),
                //   title: const Text('Settings'),
                //   onTap: () => {Navigator.of(context).pop()},
                // ),
                // ListTile(
                //   leading: const Icon(Icons.border_color),
                //   title: const Text('Feedback'),
                //   onTap: () => {Navigator.of(context).pop()},
                // ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Sign out'),
                  onTap: () => {
                    FirebaseAuth.instance.signOut(),
                    Provider.of<AccountData>(context, listen: false)
                        .clearLists(),
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const WelcomeScreen()),
                      ModalRoute.withName('/'),
                    )
                  },
                ),
              ],
            ),
          );
        });
  }
}
