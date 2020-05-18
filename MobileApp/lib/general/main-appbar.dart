import 'package:flutter/material.dart';
import '../extras/globals.dart';

Widget main_appbar(BuildContext context, title) {
  return AppBar(
      backgroundColor: primary_yellow,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(title),
          )
        ],
      ),
    );
}