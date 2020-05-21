import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../pets/pet_list_card.dart';
import '../general/main-appbar.dart';
import '../pets/new_pet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyPets extends StatefulWidget {
  @override
  _MyPets createState() => _MyPets();
}

class _MyPets extends State<MyPets> {
  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  bool loading_lists = true;
  bool fetch_error = false;
  bool logged = false;

  List<Map<String, dynamic>> listaDeMascotas;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadPetList(context);
  }

  Future<http.Response> loadPetList(BuildContext context) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'action': "get_user_pet_list", 'user_id': "user_OH9NvFh0PSu"}),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse[0]['message']);
      if (jsonResponse[0]['status'] == "true") {
        print("Checkpoint");
        setState(() {
          loading_lists = false;
          listaDeMascotas = List<Map<String, dynamic>>.from(
              jsonResponse[1]['pet_data_list']);
        });
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

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Mis mascotas");

    return Scaffold(
      appBar: appBar,
      body: loading_lists
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : Column(
              children: <Widget>[
                Expanded(
                  child: !fetch_error
                      ? ListView.builder(
                          itemCount: listaDeMascotas.length,
                          padding: EdgeInsets.all(normal_padding),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return petListCard(
                                context, jsonEncode(listaDeMascotas[index]), true, "cuidado");
                          })
                      : null,
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPet()));
        },
        child: Icon(Icons.add),
        backgroundColor: primary_green,
      ),
    );
  }
}
