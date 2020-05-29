import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuoof/extras/globals.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wuoof/general/main-appbar.dart';

class PartnerProfile extends StatefulWidget {
  @override
  _PartnerProfile createState() => _PartnerProfile();
}

class _PartnerProfile extends State<PartnerProfile> {
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String mail = "prueba@prueba.com";
  String password = "12345678";
  String name = "Ian Manuel";
  String dad_lastname = "Morales";
  String mom_lastname = "Torres";
  String city = "Cuernavaca";
  String state = "Morelos";
  String base64_img = "";

  bool edition_enabled = false;

  String edit_image = "Toca la foto para cambiarla";
  String cant_edit_image = "Bienvenido Alex";

  String edit_profile = "Editar información";
  String update_profile = "Guardar cambios";

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);

    setState(() {
      _image = image;
      base64_img = base64Encode(_image.readAsBytesSync());
    });
    //print(base64Encode(_image.readAsBytesSync()));
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Perfil");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: appBar.preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    25),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [primary_green, primary_green],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(2.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              image: DecorationImage(
                image: setImage("network", drawer_bg, true),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: getImage,
                      child: Hero(
                        tag: "profile_picture",
                        child: Container(
                          width: 120,
                          height: 120,
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.white),
                            image: DecorationImage(
                              image: _image == null
                                  ? NetworkImage(
                                      dummy_net_partner)
                                  : FileImage(_image), // <-- BACKGROUND IMAGE
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      edition_enabled ? edit_image : cant_edit_image,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
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
                                        initialValue: name,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Nombre',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Nombre',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                            return 'Ingresa tu Nombre';
                                          } else {
                                            setState(() {
                                              name = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: dad_lastname,
                                        style: TextStyle(color: Colors.black),
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.people_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Apellido paterno',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Apellido paterno',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                            return 'Ingresa tu apellido paterno';
                                          } else {
                                            setState(() {
                                              dad_lastname = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        initialValue: mom_lastname,
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.people_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Apellido materno',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Apellido materno',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                            return 'Ingresa tu apellido materno';
                                          } else {
                                            setState(() {
                                              mom_lastname = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        initialValue: mail,
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.mail_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Correo',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Correo',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                        initialValue: password,
                                        style: TextStyle(color: Colors.black),
                                        obscureText: true,
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.lock_outline,
                                              color: Colors.green),
                                          hintText: 'Contraseña actual',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Contraseña actual',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                            return 'Ingresa tu contraseña actual';
                                          } else {
                                            setState(() {
                                              password = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: password,
                                        style: TextStyle(color: Colors.black),
                                        obscureText: true,
                                        enabled: edition_enabled ? true : false,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.lock_outline,
                                              color: Colors.green),
                                          hintText:
                                              'Nueva contraseña (Opcional)',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText:
                                              'Nueva contraseña (Opcional)',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
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
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, bottom: 5),
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (edition_enabled) {
                                              if (_editProfileForm.currentState
                                                  .validate()) {
                                                //tryLogin(context);
                                              }
                                            } else {
                                              setState(() {
                                                edition_enabled = true;
                                              });
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                color: edition_enabled ? primary_green : edit_color,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: double.infinity,
                                                  minHeight: 40.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                edition_enabled
                                                    ? update_profile
                                                    : edit_profile,
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
                                          "Cancelar y volver",
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
          )
        ],
      ),
    );
  }
}