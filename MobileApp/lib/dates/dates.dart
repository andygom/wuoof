import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:wuoof/extras/globals.dart';
import '../extras/globals.dart';
import '../general/main-appbar.dart';
import 'pet-card.dart';

class DatesScreen extends StatefulWidget {
  @override
  _DatesScreen createState() => _DatesScreen();
}

class _DatesScreen extends State<DatesScreen> with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png",
    "assets/welcome2.png",
    "assets/welcome1.png",
    "assets/welcome1.png"
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    AppBar appBar = main_appbar(context, "Citas");

    return new Scaffold(
      appBar: appBar,
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(small_padding),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(small_padding),
              margin: EdgeInsets.only(bottom: small_padding),
              decoration: BoxDecoration(
                color: primary_green,
                borderRadius: BorderRadius.circular(small_border_radius)
              ),
              child: Text("Deslizar hacia la izquierda es decartar a la mascota, y a la derecha es para buscar un match", textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white
              ),),
            ),
            Container(
              height: 600,
              child: new TinderSwapCard(
                  orientation: AmassOrientation.TOP,
                  totalNum: 6,
                  stackNum: 3,
                  swipeEdge: 5.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                  cardBuilder: (context, index) => petCard(context),
                  cardController: controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                  }))
          ],
        )
      )
    );
  }
}
