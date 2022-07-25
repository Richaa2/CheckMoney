import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project2/widgets/rounded_button.dart';
import 'package:project2/utils.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                _auth.currentUser != null ? '${_auth.currentUser!.email}' : ''),
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
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              colorOfButton: Colors.lightBlueAccent,
              nameOfButton: 'Log In',
              onPress: () async {
                try {
                  final existUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (existUser != null) {
                    Navigator.pushNamed(context, '/');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
