import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project2/main_page.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/reg/button/rounded_button.dart';
import 'package:project2/utils.dart';
import 'package:provider/provider.dart';

@override
class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instanceFor(app: secondaryApp);

  bool showSpinner = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  // child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colorOfButton: Colors.blueAccent,
                nameOfButton: 'Register',
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pushNamed(context, '/');

                    setState(() {
                      showSpinner = false;
                    });
                    Provider.of<AccountData>(context, listen: false)
                        .addAccountFirebase(
                      Account(
                          colorValue: Colors.teal.value.toString(),
                          name: 'First account',
                          money: 0,
                          icon: Icons.credit_card.codePoint.toString(),
                          id: '1',
                          q: 1),
                    );
                    Provider.of<AccountData>(context, listen: false)
                        .regUser(email);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
