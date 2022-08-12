import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:project2/main_page.dart';
import 'package:project2/models/account.dart';
import 'package:project2/models/account_data.dart';
import 'package:project2/reg/button/rounded_button.dart';
import 'package:project2/reg/login_screen.dart';
import 'package:project2/utils.dart';
import 'package:provider/provider.dart';

import '../auth/bloc/auth_bloc.dart';

@override
class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instanceFor(app: secondaryApp);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // late String email;
  // late String password;

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          log(state.toString());
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          log(state.toString());
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UnAuthenticated) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 48.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your email'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? 'Enter a valid email'
                                : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && value.length < 6
                          ? "Enter min. 6 characters"
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    colorOfButton: Colors.blueAccent,
                    nameOfButton: 'Register',
                    onPress: () {
                      _createAccountWithEmailAndPassword(context);
                      // Provider.of<AccountData>(context, listen: false)
                      //     .addAccountFirebase(
                      //   Account(
                      //       colorValue: Colors.teal.value.toString(),
                      //       name: 'First account',
                      //       money: 0,
                      //       icon: Icons.credit_card.codePoint.toString(),
                      //       id: '1',
                      //       q: 1),
                      // );
                      // Provider.of<AccountData>(context, listen: false).regUser(
                      //   _emailController.text,
                      // );
                      // try {
                      //   // Navigator.pushNamed(context, '/');

                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                  ),
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );

      // Provider.of<AccountData>(context, listen: false).addAccountFirebase(
      //   Account(
      //       colorValue: Colors.teal.value.toString(),
      //       name: 'First account',
      //       money: 0,
      //       icon: Icons.credit_card.codePoint.toString(),
      //       id: '1',
      //       q: 1),
      // );
      // Provider.of<AccountData>(context, listen: false).regUser(
      //   _emailController.text,
      // );

    }
  }
}
