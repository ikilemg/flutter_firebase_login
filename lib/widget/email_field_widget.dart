import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.addListener((onListen));
  }

  @override
  void dispose() {
    widget.controller.removeListener((onListen));
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.deepPurple,
          ),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () => widget.controller.clear(),
                ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(20)),
          hintText: 'Email',
          fillColor: Colors.grey[200],
          filled: true,
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null,
      );
}
