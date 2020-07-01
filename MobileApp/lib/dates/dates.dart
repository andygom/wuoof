import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/owner/my_activities.dart';
import '../extras/globals.dart';
import '../general/main-appbar.dart';
import 'pet-card.dart';
import 'package:http/http.dart' as http;

class DatesScreen extends StatefulWidget {
  final String petData;
  DatesScreen(this.petData);

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

  bool loading_lists = true;
  bool fetch_error = false;
  bool lastItem = false;

  List<Map<String, dynamic>> listaDePerros;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadList(context);
  }

  Future<http.Response> loadList(BuildContext context) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_tinder_feed",
        "id_pet_user": "pet_kzxw5zSiqHF"
      }),
    );

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse);
      if (jsonResponse[0]['status'] == "true") {
        print("Checkpoint");
        setState(() {
          loading_lists = false;
          listaDePerros =
              List<Map<String, dynamic>>.from(jsonResponse[1]['pet_data']);
        });
        print(jsonResponse[1]['pet_data']);
      } else {
        setState(() {
          loading_lists = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        loading_lists = false;
        fetch_error = true;
      });
      _displaySnackBar(context, "No se ha podido cargar la lista de servicios");
      //throw Exception('Failed to load list.');
    }
  }

  Future<String> checkForMatch(context, index) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "¡Match con " + listaDePerros[index]["pet_name"].toString() + "!",
              textAlign: TextAlign.center,
            ),
            contentPadding:
                EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Hiciste un match con " +
                      listaDePerros[index]["pet_name"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Container(
                  height: 110,
                  padding: EdgeInsets.all(small_padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 65,
                        width: 65,
                        padding: EdgeInsets.all(small_padding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(dummy_net_img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 65,
                        width: 65,
                        transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(dummy_pet_img_2),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Grrr!',
                //  'Seguir',
                  style: TextStyle(color: primary_green),
                ),
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Wuoof!'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserActivities(0)));
                },
              ),
            ],
          );
        });
      },
    );
  }

  _displaySnackBar(context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    AppBar appBar = main_appbar(context, "Citas");

    var petData;
    String pet_img_url = "";
    String pet_name = "";

    if (checkJsonArray(context, jsonEncode(widget.petData))) {
      print(jsonEncode(widget.petData));
      petData = jsonDecode(widget.petData);
      pet_img_url = petData["pet_img_url"];
      pet_name = petData["pet_name"];
      print(pet_img_url);
    }

    return new Scaffold(
        appBar: appBar,
        body: loading_lists
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: const CircularProgressIndicator(),
                ))
            : listaDePerros == null
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: Text("¡No se encontraron resultados!"),
                    ))
                : Container(
                    padding: EdgeInsets.all(small_padding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(small_padding),
                          margin: EdgeInsets.only(bottom: small_padding),
                          decoration: BoxDecoration(
                              color: primary_green,
                              borderRadius:
                                  BorderRadius.circular(small_border_radius)),
                          child: Text(
                            "Deslizar hacia la izquierda es decartar a la mascota, y a la derecha es para buscar un match",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                            height: 550,
                            child: lastItem
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.all(normal_padding),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.sentiment_dissatisfied,
                                            color: common_grey,
                                            size: 45,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "¡Se nos terminó la lista! Vuelve después para descubrir nuevos amigos",
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  )
                                : new TinderSwapCard(
                                    orientation: AmassOrientation.TOP,
                                    totalNum: listaDePerros.length,
                                    stackNum: 3,
                                    swipeEdge: 5.0,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.9,
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.8,
                                    cardController: controller =
                                        CardController(),
                                    cardBuilder: (context, index) => petCard(
                                        context,
                                        controller,
                                        listaDePerros[index]),
                                    swipeUpdateCallback:
                                        (DragUpdateDetails details,
                                            Alignment align) {
                                      /// Get swiping card's alignment
                                      if (align.x < 0) {
                                        //Card is LEFT swiping
                                      } else if (align.x > 0) {
                                        //Card is RIGHT swiping

                                      }
                                    },
                                    swipeCompleteCallback:
                                        (CardSwipeOrientation orientation,
                                            int index) {
                                      print(orientation.toString());
                                      if (orientation.toString() ==
                                          "CardSwipeOrientation.RIGHT") {
                                        checkForMatch(context, index);
                                      } else {
                                        print("Nah");
                                      }
                                      /* if (index == (listaDePerros.length - 1)) {
                                        setState(() {
                                          lastItem = true;
                                        });
                                      } */

                                      /// Get orientation & index of swiped card!
                                    }))
                      ],
                    )));
  }
}
