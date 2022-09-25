// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/widget/email_field_widget.dart';
import 'package:flutter_login/widget/password_field_widget.dart';
import 'package:flutter_login/widget/username_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future signUp() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      username:
      _usernameController.text.trim();

      createUser(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim());
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Make sure the passwords are the same '),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  Center(
                    child: Container(
                      height: 50.0,
                      width: 650.0,
                      child: const Align(
                        alignment: FractionalOffset(0.18, 0.6),
                        child: Text(
                          'Create account ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  //USERNAME
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: UsernameFieldWidget(
                      controller: _usernameController,
                    ),
                  ),

                  SizedBox(
                    height: 15,
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PasswordFieldWidget(
                      controller: _confirmPasswordController,
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

                          signUp();
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
                            'Create',
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
                        'Already a member ? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          '  Sign In Now !',
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

  Future createUser({required String name, required String email}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    final json = {
      'name': name,
      'email': email,
    };

    await docUser.set(json);
  }
}
