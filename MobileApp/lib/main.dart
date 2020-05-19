import 'package:flutter/material.dart';
import 'user_home.dart';
import 'owner/user_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wuoof!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserHome(),
    );
  }
}