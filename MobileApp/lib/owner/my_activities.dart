import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/main-appbar.dart';
import 'package:wuoof/general/validation.dart';
import '../dates/date_item_card.dart';
import '../partner/walk_item_card.dart';
import '../partner/host_item_card.dart';
import 'package:wuoof/partner/hospedaje_item_card.dart';

var categoria_plomeria = "1";
var categoria_electricidad = "2";
var categoria_especiales = "3";
var categoria_hospedaje = "3";






class UserActivities extends StatefulWidget {
  final int tabIndex;

  UserActivities(this.tabIndex);
  @override
  _UserActivities createState() => _UserActivities();
}

class _UserActivities extends State<UserActivities> {
  bool filling_form = false;
  bool loading_lists = true;
  bool fetch_error = false;
  bool logged = false;

  String mail = null;
  String password = null;
  String user_id = null;

  List<Map<String, dynamic>> listaServicios;
  List<Map<String, dynamic>> serviciosPlomeria;
  List<Map<String, dynamic>> serviciosElectricidad;
  List<Map<String, dynamic>> serviciosEspeciales;
  List<Map<String, dynamic>> serviciosHospedaje;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadServicesList(context);
  }

  //String mail = "prueba@prueba.com";
  //String password = "12345678";





  Future<http.Response> loadServicesList(BuildContext context) async {
    final http.Response response = await http.post(
      'http://balabox-demos.com/fixme/backend/app/mods/mods',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_services_list",
        'user_id': "user_IZnaROosy5Y",
        'status': "active"
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(jsonResponse[0]['message'].toString());
      if (jsonResponse[0]['status'] == "true") {
        setState(() {
          loading_lists = false;
          listaServicios =
              List<Map<String, dynamic>>.from(jsonResponse[0]['message']);
          serviciosPlomeria = listaServicios
              .where((service) => service["category_id"] == categoria_plomeria)
              .toList();
          serviciosElectricidad = listaServicios
              .where(
                  (service) => service["category_id"] == categoria_electricidad)
              .toList();
          serviciosEspeciales = listaServicios
              .where(
                  (service) => service["category_id"] == categoria_especiales)
              .toList();
          serviciosHospedaje = listaServicios
              .where((service) => service["category_id"] == categoria_hospedaje)
              .toList();
        });
        //print(jsonResponse[0]['message'].toString());
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

  _displaySnackBar(context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  showLists(context) {
    return TabBarView(children: [
      fetch_error
          ? null
          : modelListGenerator(
              context, categoria_plomeria, serviciosPlomeria, "dates"),
      modelListGenerator(
          context, categoria_electricidad, serviciosElectricidad, "walks"),
      modelListGenerator(
          context, categoria_especiales, serviciosEspeciales, "hosts"),
      modelListGenerator(
          context, categoria_especiales, serviciosEspeciales, "hospedaje"),
    ]);
  }

  modelListGenerator(context, category, list, model) {
    var listLength;

    if (category == "") {
      listLength = list.length;
    } else {
      listLength =
          list.where((service) => service["category_id"] == category).length;
    }

    setModel(history) {
      var card_model = dateItemListCard(context, false);

      switch (model) {
        case "dates":
          card_model = dateItemListCard(context, history);
          break;

        case "walks":
          card_model = walkItemListCard(context, history);
          break;

        case "hosts":
          card_model = hostItemListCard(context, history);
          break;

        case "hospedaje":
          card_model = hospedajeItemListCard(context, history);
          break;
      }
      return card_model;
    }

    return new Padding(
      padding: EdgeInsets.all(small_padding),
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(5),
        crossAxisCount: 1,
        itemCount: listLength,
        itemBuilder: (BuildContext context, int index) => setModel(false),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //loading_lists ? loadServicesList(context) : null;
    return Scaffold(
      key: _scaffoldKey,
      appBar: main_appbar(context, "Mis actividades"),
      body: loading_lists
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : DefaultTabController(
              length: 4,
              initialIndex: widget.tabIndex,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 60),
                    child: TabBar(
                        isScrollable: false,
                        tabs: [
                          Tab(
                              icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/date-btn.png",
                                width: 30,
                              ),
                              /*  SizedBox(
                                width: 4,
                              ), */
                              Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text("Citas",
                                      style: TextStyle(fontSize: 10))),
                            ],
                          )),
                          Tab(
                              icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/walker-btn.png",
                                width: 30,
                              ),
                              /* SizedBox(
                                width: 4,
                              ), */
                              Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text("Paseos",
                                      style: TextStyle(fontSize: 10))),
                            ],
                          )),
                          Tab(
                              icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/host-btn.png",
                                width: 30,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text("Cuidados",
                                      style: TextStyle(fontSize: 10))),
                            ],
                          )),
                          Tab(
                              icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  "images/hospedaje-btn.png",
                                  width: 28,
                                ),
                              ),
                              /*    SizedBox(
                                width: 4,
                              ), */
                              Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text("Hospedaje",
                                      style: TextStyle(fontSize: 10))),
                            ],
                          )),
                        ],
                        labelColor: Colors.black,
                        indicatorColor: primary_green),
                  ),
                  Expanded(
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/white-bg.png'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.dstATop))),
                        // color: Colors.grey[300],

                        child: !fetch_error ? showLists(context) : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}




