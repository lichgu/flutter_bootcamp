import 'package:flash_chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/alert_dialog.dart';
import '../utils/auth.dart';
import '../components/rounded_button.dart';
import '../utils/data_checks.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Auth _authHandler = Auth();
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: kPrimaryColor,
              size: 40.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    cursorColor: kPrimaryColor,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) => !isEmail(value!)
                        ? "Sorry, we do not recognize this email address"
                        : null,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email.',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    cursorColor: kPrimaryColor,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) => !isPassword(value!)
                        ? "Password must be 6 or more characters in length"
                        : null,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.',
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    label: 'Log In',
                    color: kPrimaryColor,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        _authHandler
                            .handleSignInEmail(email, password)
                            .then((User user) {
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        }).catchError((e) {
                          showAlertDialog(
                              context, 'Login failed', e.toString());
                          setState(() {
                            showSpinner = false;
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
