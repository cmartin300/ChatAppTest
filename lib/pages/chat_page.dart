// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Chat Group'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
