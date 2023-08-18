// ignore_for_file: prefer_const_constructors

import 'package:chat_app/pages/main_page.dart';
import 'package:flutter/material.dart';

// TODO see about creating socket instance in main and pass it to pages that
// need to have listeners/emiters on them.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}
