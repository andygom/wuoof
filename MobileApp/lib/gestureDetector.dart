import 'package:flutter/material.dart';
import 'package:wuoof/general/main-appbar.dart';

class GestureDetectorPage extends StatefulWidget {
  @override
  _GestureDetectorPageState createState() => _GestureDetectorPageState();
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: main_appbar(context, "Gesture Dectector"),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              children: <Widget>[
                MyCards(),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ApplyButton(),
              ))
        ],
      ),
    );
  }
}

Widget ApplyButton() {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(100),
    ),
    child: RaisedButton(
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text('Apply',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          IconButton(
            icon: Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      onPressed: () {},
    ),
  );
}

class MyCards extends StatefulWidget {
  final Function onCardChanged;

  MyCards({this.onCardChanged});

  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> with SingleTickerProviderStateMixin {
  var cards = [
    TheCard(
      index: 0,
      color: Colors.red[100],
      iconCard: "Icons.pets",
      titleCard: "Card 1",
      infoCard: "Card for gestureDetector 1",
    ),
    TheCard(
      index: 1,
      color: Colors.orange[100],
      iconCard: "Icons.pets",
      titleCard: "Card 1",
      infoCard: "Card for gestureDetector 1",
    ),
    TheCard(
      index: 2,
      color: Colors.green[100],
      iconCard: "Icons.pets",
      titleCard: "Card 1",
      infoCard: "Card for gestureDetector 1",
    ),
    TheCard(
      index: 3,
      color: Colors.blue[100],
      iconCard: "Icons.pets",
      titleCard: "Card 1",
      infoCard: "Card for gestureDetector 1",
    ),
  ];

  int currentIndex;
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    controller:
    AnimationController(
      vsync: this,
      duration: Duration(microseconds: 150),
    );
    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);

    animation = Tween(begin: Offset(0.0, 0.05), end: Offset(0, 0))
        .animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        overflow: Overflow.visible,
        children: cards.reversed.map((card) {
          if (cards.indexOf(card) <= 2) {
            return GestureDetector(
              onHorizontalDragEnd: cardDrag,
              child: FractionalTranslation(
                translation: stackedCard(card),
                child: card,
              ),
            );
          } else {
            return Container();
          }
        }).toList());
  }

  Offset stackedCard(TheCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex + 1) {
      return animation.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0, 0.05 * diff);
    } else {
      return Offset(0, 0);
    }
  }

  void cardDrag(DragEndDetails details) {
    controller.reverse().whenComplete(() {
      setState(() {
        controller.reset();
        TheCard removedCard = cards.removeAt(0);
        cards.add(removedCard);
        currentIndex = cards[0].index;
      });
    });
  }
}

class TheCard extends StatelessWidget {
  final int index;
  final Color color;
  final String iconCard, titleCard, infoCard;

  TheCard(
      {this.index, this.color, this.iconCard, this.titleCard, this.infoCard});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(50),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          width: 300,
          height: 400,
          color: color,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Icon(Icons.pets, size: 40),
              ),
              SizedBox(
                height: 20,
              ),
              
            ],
          ),
        ));
  }
}
