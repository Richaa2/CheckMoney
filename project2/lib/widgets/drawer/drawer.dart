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
    String name = '';
    String inputName = '';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 65, 175, 133),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${FirebaseAuth.instance.currentUser!.email}'),
                Text(Provider.of<AccountData>(
                      context,
                    ).nameOfAccount ??
                    ''),
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
                              .updateNameOfAccount(inputName);
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
              Provider.of<AccountData>(context, listen: false).ClearLists(),
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const WelcomeScreen()),
                ModalRoute.withName('/'),
              )
            },
          ),
        ],
      ),
    );
  }
}
