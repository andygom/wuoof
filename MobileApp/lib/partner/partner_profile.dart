import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/formField.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wuoof/general/main-appbar.dart';
import 'package:wuoof/general/partner-appbar.dart';
import 'package:wuoof/general/validation.dart';

class PartnerProfile extends StatefulWidget {
  @override
  _PartnerProfile createState() => _PartnerProfile();
}

class _PartnerProfile extends State<PartnerProfile> {
  bool newPasswordPressed = true;
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String mail = "alex@torres.com";
  String password = "12345678";
  String name = "Alex";
  String dad_lastname = "Morales";
  String mom_lastname = "Torres";
  String city = "Cuernavaca";
  String state = "Morelos";
  String base64_img = "";
  String biography = dummy_partner_bio;

  bool edition_enabled = false;

  String edit_image = "Toca la foto para cambiarla";
  String cant_edit_image = "Bienvenido Alex";

  String edit_profile = "Editar";
  String update_profile = "Wuoof!";

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
    AppBar appBar = partner_appbar(context, "Perfil");

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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/partner-bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop))),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
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
                                  ? NetworkImage(dummy_net_partner)
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
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/white-bg.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.dstATop))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 15, right: 15),
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
                                        SimpleTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: name,
                                          icon: Icons.person_outline,
                                          label: 'name',
                                          labelText: 'Nombre',
                                          onSaved: (input) => name = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: dad_lastname,
                                          icon: Icons.people_outline,
                                          label: 'lastName',
                                          labelText: 'Apellido paterno',
                                          onSaved: (input) =>
                                              dad_lastname = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: mom_lastname,
                                          icon: Icons.people_outline,
                                          label: 'lastName',
                                          labelText: 'Apellido materno',
                                          onSaved: (input) =>
                                              mom_lastname = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          label: 'bio',
                                          initValue: biography,
                                          maxLength: 150,
                                          maxLines: 5,
                                          enabled: edition_enabled,
                                          icon: Icons.person_outline,
                                          helperText: '',
                                          labelText: 'Biografía',
                                          onSaved: (input) => biography = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: mail,
                                          icon: Icons.mail_outline,
                                          label: 'email',
                                          labelText: 'Correo',
                                          onSaved: (input) => mail = input,
                                        ),
                                         edition_enabled
                                            ? TextFormField(
                                                enabled: edition_enabled
                                                    ? true
                                                    : false,
                                                initialValue: '',
                                                style: TextStyle(
                                                    color: Colors.black),
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                  suffixIcon: Icon(
                                                      Icons.lock_outline,
                                                      color: Colors.green),
                                                  hintText: 'Contraseña actual',
                                                  hintStyle: TextStyle(
                                                    color: Colors.black38,
                                                  ),
                                                  labelText:
                                                      'Contraseña actual',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black38,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  errorBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                validator:
                                                    passwordDataBaseValidator,
                                                onChanged: (val) =>
                                                    password = val,
                                              )
                                            : Container(),
                                        edition_enabled && newPasswordPressed
                                            ? Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20, bottom: 5),
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        newPasswordPressed =
                                                            false;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    child: Ink(
                                                      decoration: BoxDecoration(
                                                          color: primary_blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: double
                                                                    .infinity,
                                                                minHeight:
                                                                    40.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Cambiar contraseña',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // _newPassword(context, edition_enabled,
                                        //     newpasword, newPasswordPressed),
                                        newPasswordPressed
                                            ? Container()
                                            : Column(
                                                children: <Widget>[
                                                  TextFormField(
                                                    initialValue: '',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    obscureText: true,
                                                    enabled: edition_enabled
                                                        ? true
                                                        : false,
                                                    decoration:
                                                        const InputDecoration(
                                                      suffixIcon: Icon(
                                                          Icons.lock_outline,
                                                          color: Colors.green),
                                                      hintText:
                                                          'Nueva contraseña',
                                                      hintStyle: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                      labelText:
                                                          'Nueva contraseña ',
                                                      labelStyle: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                      errorStyle: TextStyle(
                                                          color: Colors.red),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    onChanged: (val) =>
                                                        password = val,
                                                    validator:
                                                        passwordValidator,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted: (_) =>
                                                        FocusScope.of(context)
                                                            .nextFocus(),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    obscureText: true,
                                                    enabled: edition_enabled
                                                        ? true
                                                        : false,
                                                    decoration:
                                                        const InputDecoration(
                                                      suffixIcon: Icon(
                                                          Icons.lock_outline,
                                                          color: Colors.green),
                                                      hintText:
                                                          'Confirma nueva contraseña',
                                                      hintStyle: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                      labelText:
                                                          'Confirma nueva contraseña',
                                                      labelStyle: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                      errorStyle: TextStyle(
                                                          color: Colors.red),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    onChanged: (val) =>
                                                        password = val,
                                                    validator: (val) =>
                                                        MatchValidator(
                                                                errorText:
                                                                    'Las contraseñas no coinciden')
                                                            .validateMatch(
                                                                val, password),
                                                  ),
                                                ],
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 5),
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (edition_enabled) {
                                                if (_editProfileForm
                                                    .currentState
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
                                                  color: edition_enabled
                                                      ? primary_green
                                                      : edit_color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
