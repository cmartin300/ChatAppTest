// ignore_for_file: prefer_const_constructors

import 'dart:core';

import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';

class AlertPopupFormField extends StatefulWidget {
  final String popupTitle;
  final String userID;

  const AlertPopupFormField({
    super.key,
    required this.popupTitle,
    required this.userID,
  });

  @override
  State<AlertPopupFormField> createState() => _AlertPopupFormFieldState();
}

class _AlertPopupFormFieldState extends State<AlertPopupFormField> {
  // VARIABLES
  //
  TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Funtions
  //
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ENTER BUTTON
    //
    Widget enterButton = TextButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String username = usernameController.text;
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                    username: username,
                    userID: widget.userID,
                  )));
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
      content: Form(
        key: formKey,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Valid username required";
            }
            return null;
          },
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Enter a username",
          ),
        ),
      ),
      actions: [
        cancelButton,
        enterButton,
      ],
    );
  }
}
