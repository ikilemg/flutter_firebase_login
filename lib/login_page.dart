// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/widget/email_field_widget.dart';
import 'package:flutter_login/widget/password_field_widget.dart';

import 'package:turkish/turkish.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 195,
                  ),
                  Center(
                    child: Container(
                      height: 50.0,
                      width: 650.0,
                      child: const Align(
                        alignment: FractionalOffset(0.11, 0.6),
                        child: Text(
                          'Login ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 25.0,
                      width: 650.0,
                      child: const Align(
                        alignment: FractionalOffset(0.165, 0.6),
                        child: Text(
                          'Enter Account Details to Continue',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: EmailFieldWidget(
                      controller: _emailController,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PasswordFieldWidget(
                      controller: _passwordController,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //Sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        final form = formKey.currentState!;

                        if (form.validate()) {
                          TextInput.finishAutofillContext();
                          final email = _emailController.text.trim();

                          signIn();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //register button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          '  Sign Up Now !',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
