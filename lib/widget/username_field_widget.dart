// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class UsernameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const UsernameFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<UsernameFieldWidget> createState() => _UsernameFieldWidgetState();
}

class _UsernameFieldWidgetState extends State<UsernameFieldWidget> {
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.deepPurple,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(20)),
          hintText: 'Username',
          fillColor: Colors.white,
          filled: true,
        ),
        keyboardType: TextInputType.name,
        validator: (username) =>
            username != null && username.length < 2 ? 'Enter a value' : null,
      );
}
