import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/main_page.dart';

import 'package:project2/reg/button/rounded_button.dart';
import 'package:project2/reg/registration_screen.dart';
import 'package:project2/utils.dart';

import '../auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _auth = FirebaseAuth.instanceFor(app: secondaryApp);
  // late String email;
  // late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
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
                  Text(_auth.currentUser != null
                      ? '${_auth.currentUser!.email}'
                      : ''),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value != null &&
                                      !EmailValidator.validate(value)
                                  ? 'Enter a valid email'
                                  : null;
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            // onChanged: (value) {
                            //   email = value;
                            // },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your email')),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            return value != null && value.length < 6
                                ? "Enter min. 6 characters"
                                : null;
                          },
                          // onChanged: (value) {
                          //   password = value;
                          // },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your password'),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    colorOfButton: Colors.lightBlueAccent,
                    nameOfButton: 'Log In',
                    onPress: () async {
                      _authenticateWithEmailAndPassword(context);
                      // try {
                      //   final existUser =
                      //       await _auth.signInWithEmailAndPassword(
                      //           email: email, password: password);
                      // if (existUser != null) {
                      //   Navigator.pushNamed(context, '/');
                      // }
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                  ),
                  const Text("Don't have an account?",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  Flexible(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationScreen()),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }
}
