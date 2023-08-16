// ignore_for_file: prefer_const_constructors

import 'dart:core';

import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';

class AlertPopupFormField extends StatefulWidget {
  final String popupTitle;

  const AlertPopupFormField({
    super.key,
    required this.popupTitle,
  });

  @override
  State<AlertPopupFormField> createState() => _AlertPopupFormFieldState();
}

class _AlertPopupFormFieldState extends State<AlertPopupFormField> {
  TextEditingController usernameController = TextEditingController();
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_updateValidation);
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void _updateValidation() {
    setState(() {
      isValidated = usernameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ENTER BUTTON
    //
    Widget enterButton = TextButton(
      onPressed: () {
        if (isValidated) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatPage()));
        } else {
          return;
        }
      },
      child: Text('Enter'),
    );
    // CANCEL BUTTON
    //
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'),
    );
    // ALERT POPUP
    //
    return AlertDialog(
      title: Text(widget.popupTitle),
      content: TextField(
        controller: usernameController,
        decoration: InputDecoration(
          hintText: "Enter a username",
          errorText: isValidated ? null : "Enter a valid username.",
        ),
      ),
      actions: [
        cancelButton,
        enterButton,
      ],
    );
  }
}
