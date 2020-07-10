import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => dateInit(context));
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
    return showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.8),
        barrierDismissible: false,
        barrierLabel: "Dialog",
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (context, _, __) {
          return Scaffold(
              backgroundColor: Colors.black12.withOpacity(0.1),
              body: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '¡Hiciste Match!',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tienes un match con " +
                                listaDePerros[index]["pet_name"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _petMatch(dummy_net_img),
                              Transform.rotate(
                                angle: 180,
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.bone,
                                    color: Colors.green[200],
                                  ),
                                  onPressed: null,
                                ),
                              ),
                              _petMatch(dummy_pet_img_2),
                            ],
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserActivities(0)));
                              },
                              child: Container(
                                width: 300,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      small_border_radius),
                                  color: primary_green,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(
                                    //   Icons.message,
                                    //   color: Colors.white,
                                    //   size: 16,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Enviar mensaje a " +
                                          listaDePerros[index]["pet_name"]
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 300,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primary_green),
                                  borderRadius: BorderRadius.circular(
                                      small_border_radius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(
                                    //   Icons.pets,
                                    //   color: Colors.white,
                                    //   size: 16,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Seguir',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ));
        });
  }

  Future<String> dateInit(context) async {
    return showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.3),
        barrierDismissible: false,
        barrierLabel: "Dialog",
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (context, _, __) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Scaffold(
                backgroundColor: Colors.black12.withOpacity(0.3),
                body: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Text('Desliza a la izquierda para decartar a la mascota', style: TextStyle(color: Colors.white),),
                          SizedBox(width: 10,),
                          Text(' y a la derecha para buscar un match', style: TextStyle(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
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
                        // Container(
                        //   padding: EdgeInsets.all(small_padding),
                        //   margin: EdgeInsets.only(bottom: small_padding),
                        //   decoration: BoxDecoration(
                        //       color: primary_green,
                        //       borderRadius:
                        //           BorderRadius.circular(small_border_radius)),
                        //   child: Text(
                        //     "Deslizar hacia la izquierda es decartar a la mascota, y a la derecha es para buscar un match",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        // ),
                        Container(
                            height: 600,
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

Widget _petMatch(petimg) {
  return Container(
    height: 120,
    width: 120,
    //   transform: Matrix4.translationValues(7.0, 0.0, 0.0),
    decoration: BoxDecoration(
      border: Border.all(width: 2, color: Colors.white),
      borderRadius: BorderRadius.circular(100),
      image: DecorationImage(
        image: NetworkImage(petimg),
        fit: BoxFit.cover,
      ),
    ),
  );
}
