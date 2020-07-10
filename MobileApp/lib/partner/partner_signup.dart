import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/formField.dart';
import 'package:wuoof/general/validation.dart';
import 'package:wuoof/owner/user_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//import 'new_petform.dart';

const greencolor = const Color(0xFF4FB961);

class PartnerSignup extends StatefulWidget {
  final String partner_type;
  PartnerSignup(this.partner_type);

  @override
  _PartnerSignup createState() => _PartnerSignup();
}

class _PartnerSignup extends State<PartnerSignup> {
  bool filling_form = false;
  final _myForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String name;
  String first_lastname;
  String second_lastname;
  String phone;
  String mail;
  String password;
  String confirmed_password;
  DateTime birthdate = DateTime.now();
  String birthdate_string =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      fieldLabelText: 'Ingresa la fecha',
      locale : const Locale("es","MX"),
        helpText: 'selecciona tu fecha de nacimiento',
        cancelText: 'Cancelar',
        confirmText: 'Ok',
        context: context,
        initialDate: birthdate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthdate)
      setState(() {
        birthdate = picked;
        birthdate_string =
            "${birthdate.day}-${birthdate.month}-${birthdate.year}";
      });
  }

  //String mail = "prueba@prueba.com";
  //String password = "12345678";

  Future<http.Response> submitForm(context) async {
    setState(() {
      filling_form = true;
    });
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "action": "signup",
        "name": name,
        "first_lastname": first_lastname,
        "second_lastname": second_lastname,
        "img_url": "dummy.jpg",
        "birth_date": birthdate_string,
        "phone": phone,
        "state": " ",
        "municipality": " ",
        "gender": " ",
        "mail": mail,
        "password": password,
        "type": "partner"
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print("Good");
      if (jsonResponse[0]['status'] == "true") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
      _displaySnackBar(context,
          "No se ha podido registrar tu cuenta, revisa tu conexión a internet.");
      throw Exception('Failed to signup.');
    }
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  goHome(context) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: filling_form
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: const CircularProgressIndicator(),
                ))
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/white-bg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop))),
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
                              child: Image.asset('images/logo-fondo-blanco.png',
                                  height: 170),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text('Únete al equipo!',
                                        style: TextStyle(
                                          color: common_grey,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Form(
                            key: _myForm,
                            child: Padding(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.words,
                                    label: 'name',
                                    // maxLength: null,
                                    enabled: true,
                                    icon: Icons.person_outline,
                                    hintText: 'Nombre',
                                    labelText: 'Nombre',
                                    onSaved: (input) => name = input,
                                  ),
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.words,
                                    label: 'lastName',
                                    // maxLength: null,
                                    enabled: true,
                                    icon: Icons.people_outline,
                                    hintText: 'Apellido Paterno',
                                    labelText: 'Apellido Paterno',
                                    onSaved: (input) => first_lastname = input,
                                  ),
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.words,
                                    label: 'lastName',
                                    // maxLength: null,
                                    enabled: true,
                                    icon: Icons.people_outline,
                                    hintText: 'Apellido Materno',
                                    labelText: 'Apellido Materno',
                                    onSaved: (input) => second_lastname = input,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 15),
                                    padding: EdgeInsets.all(small_padding),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(
                                            small_border_radius)),
                                    child: InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Fecha de nacimiento"),
                                            Text(
                                              birthdate_string.toString(),
                                              style: TextStyle(
                                                  color: common_grey,
                                                  fontSize: 15),
                                            )
                                          ],
                                        )),
                                  ),
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.none,
                                    label: 'phone',
                                    // maxLength: null,
                                    enabled: true,
                                    icon: Icons.phone_android,
                                    hintText: 'Teléfono',
                                    labelText: 'Teléfono',
                                    onSaved: (input) => phone = input,
                                  ),
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.none,
                                    label: 'email',
                                    // maxLength: null,
                                    enabled: true,
                                    icon: Icons.mail_outline,
                                    hintText: 'Correo',
                                    labelText: 'Correo',
                                    onSaved: (input) => mail = input,
                                  ),
                                  SimpleTextField(
                                    textCapitalization: TextCapitalization.none,
                                    maxLines: 1,
                                    label: 'password',
                                    // maxLength: null,
                                    enabled: true,
                                    // icon: Icons.lock_outline,
                                    hintText: 'Contraseña',
                                    labelText: 'Contraseña',
                                    onSaved: (input) => password = input,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 5),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_myForm.currentState.validate()) {
                                          submitForm(context);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
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
                                                BorderRadius.circular(8.0)),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: double.infinity,
                                              minHeight: 40.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Wuoof!",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
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
                                          ),
                                          text: '¿Ya tienes cuenta? '),
                                      new TextSpan(
                                          text: 'Inicia sesión',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
