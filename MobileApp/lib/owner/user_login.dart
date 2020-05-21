import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/owner/register_owner.dart';
import '../general/user_type.dart';
import '../user_home.dart';
import '../pets/new_pet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const orangecolor = const Color(0xFFE6B548);
const yellowcolor = const Color(0xFFFACA5E);
const greencolor = const Color(0xFF4FB961);

Column _buildButtonColumn(Color color, IconData icon) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: greencolor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.19),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                3.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Icon(icon, color: color, size: 35),
      ),
    ],
  );
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  static _LoginPage of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoginPage>());

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int _counter = 0;
  bool filling_form = false;
  final _myForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String mail = "prueba@prueba.com";
  String password = "12345678";

  bool hasPet = true;

  Future<http.Response> tryLogin(context) async {
    setState(() {
      filling_form = true;
    });
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "login",
        'mail': mail,
        'password': password,
        'user_type': 'client'
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse);
      if (jsonResponse[0]['status'] == "true") {
        String user_id = jsonResponse[1]['user_id'];

        if (user_id != null) {
          //storeLoginData(mail, user_id, token, context);
          getUserData(user_id, context);
        }
      } else {
        setState(() {
          filling_form = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        filling_form = false;
      });
      _displaySnackBar(context, "No se ha podido iniciar sesión");
      throw Exception('Failed to login.');
    }
  }

  Future<http.Response> getUserData(user_id, context) async {
    setState(() {
      filling_form = true;
    });
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_user_public_data",
        'user_id': user_id
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse[0]['status'] == "true") {
        String user_data = jsonEncode(jsonResponse[1]['user_data'][0]);
        if (user_data != null) {
          storeLoginData(user_data, user_id, context);
        }
        //print(jsonDecode(user_data)["name"]);
      } else {
        setState(() {
          filling_form = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        filling_form = false;
      });
      _displaySnackBar(context, "No se ha podido iniciar sesión");
      throw Exception('Failed to login.');
    }
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  storeLoginData(user_data, user_id, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', user_data);
    await prefs.setString('user_id', user_id);
    goHome(context);
  }

  goHome(context) {
    !hasPet
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewPet()),
          )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHome("")),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: filling_form
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [orangecolor, yellowcolor],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(2.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30, bottom: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Image.asset(
                                    'images/logo-fondo-blanco.png',
                                    height: 170),
                              ),
                            ),
                            Container(
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text('Inicia sesión',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Form(
                                        key: _myForm,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            TextFormField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                hintText: 'Usuario',
                                                hintStyle: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                                labelText: 'Usuario',
                                                labelStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greencolor),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.yellow),
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.yellow),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Ingresa tu correo';
                                                } else {
                                                  setState(() {
                                                    mail = value;
                                                  });
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              //controller: TextEditingController(text: "123456789"),
                                              style: TextStyle(
                                                  color: Colors.white),
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                hintText: 'Contraseña',
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                labelText: 'Contraseña',
                                                labelStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greencolor),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.yellow),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.yellow),
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.yellow),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Ingresa tu contraseña';
                                                } else {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                }
                                                return null;
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 5),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  if (_myForm.currentState
                                                      .validate()) {
                                                    tryLogin(context);
                                                  }                                                  
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                padding: EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                      color: greencolor,
                                                      /* gradient: LinearGradient(
                                                        colors: [
                                                          Colors.lightGreen,
                                                          Colors
                                                              .lightGreenAccent
                                                        ],
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                      ), */
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth:
                                                            double.infinity,
                                                        minHeight: 40.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Entrar",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 20, bottom: 15),
                                                child: InkWell(
                                                    child: Text(
                                                      "¿Olvidaste tu contraseña?",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    onTap: () {
                                                      /* Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()),
                                              );       */
                                                    })),
                                            Padding(
                                              padding: EdgeInsets.only(top: 20),
                                            ),
                                            Row(children: <Widget>[
                                              Expanded(
                                                  child: Divider(
                                                color: Colors.white,
                                              )),
                                              Text(" Ó entra con: ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white)),
                                              Expanded(
                                                  child: Divider(
                                                color: Colors.white,
                                              )),
                                            ]),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  _buildButtonColumn(
                                                      Colors.white,
                                                      FontAwesomeIcons
                                                          .facebookF),
                                                  _buildButtonColumn(
                                                      Colors.white,
                                                      FontAwesomeIcons.google),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserType()),
                                          );
                                        },
                                        child: RichText(
                                          text: new TextSpan(
                                            style: new TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  style: new TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                  text: '¿Eres nuevo? '),
                                              new TextSpan(
                                                  text: 'Regístrate aquí',
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
