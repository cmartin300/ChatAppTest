// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/alert_popup.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Chat App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertPopupFormField(popupTitle: "Username"),
                );
              },
              child: Text('Join chat group -->'),
            ),
          ),
        ],
      ),
    );
  }
}
