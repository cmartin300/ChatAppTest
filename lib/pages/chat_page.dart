// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/widgets/other_message_widget.dart';
import 'package:chat_app/models/widgets/self_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String username;
  final String userID;
  const ChatPage({
    super.key,
    required this.username,
    required this.userID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  List<MessageModel> messageList = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect(
      (_) {
        socket!.on(
          "serverMessage",
          (data) {
            if (data["userID"] != widget.userID) {
              setState(() {
                messageList.add(
                  MessageModel(
                    message: data["message"],
                    type: data["type"],
                    sender: data["sender"],
                  ), // MessageModel
                );
              });
            }
          },
        ); // Socket.on "serverMessage"
      },
    ); // Socket onConnect
  }

  void sendMessage(String message, String sender) {
    MessageModel selfMessage =
        MessageModel(message: message, type: "selfMessage", sender: sender);

    messageList.add(selfMessage);

    setState(() {
      messageList;
    });

    socket!.emit('sendMessage', {
      "type": "selfMessage",
      "message": message,
      "sender": sender,
      "userID": widget.userID,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            socket!.dispose();
            Navigator.pop(context);
          },
        ),
        title: Text('Chat Group'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                if (messageList[index].type == "selfMessage") {
                  return SelfMessageWidget(
                      message: messageList[index].message,
                      sender: messageList[index].sender);
                } else {
                  return OtherMessageWidget(
                      message: messageList[index].message,
                      sender: messageList[index].sender);
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter text here ...',
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            sendMessage(
                              messageController.text,
                              widget.username,
                            );
                          }
                          messageController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
