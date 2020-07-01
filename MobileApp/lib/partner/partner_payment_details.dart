import 'package:flutter/material.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/partner-appbar.dart';

class PartnerPaymentDetails extends StatefulWidget {
  @override
  _PartnerPaymentDetails createState() => _PartnerPaymentDetails();
}

class _PartnerPaymentDetails extends State<PartnerPaymentDetails> {
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String password = "";
  String banco = "BBVA";
  String clabe = "0125 12439 98234709";
  String no_de_tarjeta = "5522 1922 2889 0012";

  

  @override
  Widget build(BuildContext context) {
    AppBar appBar = partner_appbar(context, "Datos de pago");
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/white-bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop))),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Column(
                                children: <Widget>[
                                  Form(
                                    key: _editProfileForm,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: banco,
                                          style: TextStyle(color: Colors.black),
                                          //initialValue: "prueba@prueba.com",
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.person_outline,
                                              color: Color(0xFF114a9e),
                                            ),
                                            hintText: 'Banco',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                            labelText: 'Banco',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF114a9e)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.blue),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Ingresa tu Banco';
                                            } else {
                                              setState(() {
                                                banco = value;
                                              });
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          initialValue: clabe,
                                          style: TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.people_outline,
                                              color: Color(0xFF114a9e),
                                            ),
                                            hintText: 'CLABE',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                            labelText: 'CLABE',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF114a9e)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.blue),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Ingresa tu CLABE';
                                            } else {
                                              setState(() {
                                                clabe = value;
                                              });
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          initialValue: no_de_tarjeta,
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.people_outline,
                                              color: Color(0xFF114a9e),
                                            ),
                                            hintText: 'Número de tarjeta',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                            labelText: 'Número de tarjeta',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF114a9e)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.blue),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Ingresa tu Número de tarjeta';
                                            } else {
                                              setState(() {
                                                no_de_tarjeta = value;
                                              });
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          initialValue: password,
                                          style: TextStyle(color: Colors.black),
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons.lock_outline,
                                                color: Color(0xFF114a9e)),
                                            hintText: 'Contraseña',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                            labelText: 'Contraseña',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF114a9e)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.blue),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
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
                                          padding:
                                              EdgeInsets.only(top: 20, bottom: 5),
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (_editProfileForm.currentState
                                                  .validate()) {
                                                //tryLogin(context);
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            padding: EdgeInsets.all(0.0),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      primary_green,
                                                      primary_green
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5.0)),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: double.infinity,
                                                    minHeight: 40.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Wuoof!",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Grrr!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Image.network('http://circlecitygogirls.com/wp-content/uploads/2013/01/indy1.png'), */
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}