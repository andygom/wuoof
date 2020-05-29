import 'package:flutter/material.dart';
import 'package:wuoof/owner/checkout.dart';
import 'package:wuoof/owner/requesting.dart';
import 'package:wuoof/partner/partner_home.dart';
import 'package:wuoof/partner/partner_profile.dart';
import 'user_home.dart';
import 'owner/user_login.dart';
import 'owner/register_owner.dart';
import 'general/chat.dart';
import 'partner/partner_signup.dart';

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
      home: UserHome("")
    );
  }
}