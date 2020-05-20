import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../pets/pet_list_card.dart';
import '../general/main-appbar.dart';
import '../general/conversation_card.dart';

class Inbox extends StatefulWidget {
  @override
  _Inbox createState() => _Inbox();
}

class _Inbox extends State<Inbox> {
  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Inbox");

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.all(normal_padding),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return conversationListCard(context);
                }),
          )
        ],
      ),
    );
  }
}
