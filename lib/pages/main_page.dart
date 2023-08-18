// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/alert_popup.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var uuid = Uuid();
  // IO.Socket? socket;

  // @override
  // void initState() {
  //   super.initState();
  //   connectToSocket();
  // }

  // void connectToSocket() {
  //   socket = IO.io("http://localhost:3000", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket!.connect();
  //   socket!.onConnect(
  //     (_) {
  //       socket!.on("Alert", (data) {
  //         showMeetingAlert(data["data"].toString());
  //       });
  //     },
  //   );
  // }

  // void callMeeting(String typeOfMeeting) {
  //   socket!.emit("meetingAlert", typeOfMeeting);
  // }

  // void showMeetingAlert(String typeOfMeeting) {
  //   var snackBar = SnackBar(
  //     content: Text(
  //         'A ${typeOfMeeting.toLowerCase()} has been ${typeOfMeeting == "Body" ? "reported" : "called"}!'),
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    var userID = uuid.v1();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // callMeeting("Meeting");
              },
              icon: Icon(Icons.add_alert))
        ],
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
                  builder: (context) => AlertPopupFormField(
                    popupTitle: "Username",
                    userID: userID,
                  ),
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
