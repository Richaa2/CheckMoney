import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/widgets/rounded_button.dart';
import 'package:project2/utils.dart';
import 'package:provider/provider.dart';

@override
class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
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
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, '/');

                      setState(() {
                        showSpinner = false;
                      });
                      Provider.of<AccountData>(context, listen: false)
                          .addAccountFirebase(Account(
                              colorValue: Colors.teal.value.toString(),
                              name: 'First account',
                              money: 0,
                              icon: Icons.credit_card.codePoint.toString(),
                              id: '1',
                              q: 1));
                    }
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
