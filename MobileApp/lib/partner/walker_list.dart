import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../general/main-appbar.dart';
import 'list-card.dart';

class WalkerList extends StatefulWidget {
  @override
  _WalkerList createState() => _WalkerList();
}

class _WalkerList extends State<WalkerList> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: primary_yellow,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text("Paseadores"),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                color: primary_yellow,
                padding: EdgeInsets.all(normal_padding),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(80),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("images/walker-btn.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Encuentra al cuidador ideal para tu mascota",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.all(normal_padding),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return partnerListCard(context,true);
                  }),
            )
          ],
        ));
  }
}
