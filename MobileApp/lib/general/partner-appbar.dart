import 'package:flutter/material.dart';
import '../extras/globals.dart';

Widget partner_appbar(BuildContext context, title) {
  return AppBar(
      backgroundColor: primary_green,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(title),
          )
        ],
      ),
       actions: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image.asset(
          "images/facewuoof-logo.png",
          width: 35,
        ),
      )
    ],
    );
}