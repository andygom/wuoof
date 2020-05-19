import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/main-appbar.dart';
import '../pets/pet_list_card.dart';

void main() {
  runApp(UserActivities());
}

var categoria_plomeria = "1";
var categoria_electricidad = "2";
var categoria_especiales = "3";


class UserActivities extends StatefulWidget {
  @override
  _UserActivities createState() => _UserActivities();
}

class _UserActivities extends State<UserActivities> {
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadServicesList(context);
  }

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
      fetch_error ? null : 
      modelListGenerator(context, categoria_plomeria, serviciosPlomeria),
      modelListGenerator(
          context, categoria_electricidad, serviciosElectricidad),
      modelListGenerator(context, categoria_especiales, serviciosEspeciales),
    ]);
  }

  modelListGenerator(context, category, list) {
  var listLength;

  if (category == "") {
    listLength = list.length;
  } else {
    listLength =
        list.where((service) => service["category_id"] == category).length;
  }

  return new Padding(
    padding: EdgeInsets.all(small_padding),
    child: StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(7),
      crossAxisCount: 1,
      itemCount: listLength,
      itemBuilder: (BuildContext context, int index) => petListCard(context, false, "Mascota"),
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
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 50),
                        child: TabBar(
                            isScrollable: false,
                            tabs: [
                              Tab(text: "Citas"),
                              Tab(text: "Paseos"),
                              Tab(text: "Cuidados"),
                            ],
                            labelColor: Colors.black,
                            indicatorColor: Colors.blueAccent),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          child: !fetch_error ? showLists(context) : null,
                        ),
                      )
                    ],
                  ),
                ),
        );
  }
}
