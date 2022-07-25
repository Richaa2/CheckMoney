import 'package:flutter/material.dart';

import 'package:project2/reg/registration_screen.dart';
import 'package:project2/widgets/rounded_button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Welcome'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Choose way',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 48,
                ),
                RoundedButton(
                  nameOfButton: 'Log in',
                  colorOfButton: Colors.lightBlueAccent,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
                RoundedButton(
                  nameOfButton: 'Register',
                  colorOfButton: Colors.blueAccent,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()));
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
