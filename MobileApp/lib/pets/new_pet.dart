import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuoof/extras/globals.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wuoof/general/main-appbar.dart';

class NewPet extends StatefulWidget {
  @override
  _NewPet createState() => _NewPet();
}

class _NewPet extends State<NewPet> {
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String pet_name = "";
  String profile_pic_base64 = "";
  String nationality = "";
  String birth_date = "";
  String biography = "";
  String allergies_and_treatment = "";
  String training = "";
  String diet = "";
  String pet_sociable = null;
  String kid_sociable = null;
  String vaccines = null;
  String sterilized = null;
  String extra_info = "";
  String size = null;
  String breed = null;
  String gender = null;
  String characteristics = "";

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);

    setState(() {
      _image = image;
      profile_pic_base64 = base64Encode(_image.readAsBytesSync());
    });
    //print(base64Encode(_image.readAsBytesSync()));
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Nueva mascota");

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
                  colors: [primary_yellow, primary_yellow],
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
                                  ? NetworkImage(dummy_net_img)
                                  : FileImage(_image), // <-- BACKGROUND IMAGE
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "¡Selecciona una foto de perfil para tu mascota!",
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
                                        initialValue: pet_name,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
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
                                            return 'Ingresa el nombre de tu mascota';
                                          } else {
                                            setState(() {
                                              pet_name = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: pet_name,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",

                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Nacionalidad',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Nacionalidad',
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
                                            return 'Ingresa la Nacionalidad de tu mascota';
                                          } else {
                                            setState(() {
                                              nationality = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: pet_name,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",

                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Fecha de nacimiento',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Fecha de nacimiento',
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
                                            return 'Ingresa la Fecha de nacimiento de tu mascota';
                                          } else {
                                            setState(() {
                                              birth_date = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: pet_name,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Biografía',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Biografía',
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
                                            return 'Ingresa la Biografía de tu mascota';
                                          } else {
                                            setState(() {
                                              biography = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: allergies_and_treatment,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          helperText:
                                              "Describe si tiene algún tipo de alergia o si requiere de cuidados médicos especiales",
                                          helperMaxLines: 3,
                                          hintText: 'Alergias y cuidados',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Alergias y cuidados',
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
                                            return 'Es necesario completar este campo';
                                          } else {
                                            setState(() {
                                              allergies_and_treatment = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: training,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          helperText:
                                              "Describe si tiene algún tipo de entrenamiento, como sentarse, hacer del baño, etc.",
                                          helperMaxLines: 3,
                                          hintText: 'Entrenamiento',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Entrenamiento',
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
                                            return 'Es necesario completar este campo';
                                          } else {
                                            setState(() {
                                              training = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: diet,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          helperText:
                                              "Describe si lleva alguna dieta en especial o si debe comer ciertos alimentos.",
                                          helperMaxLines: 3,
                                          hintText: 'Dieta',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Dieta',
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
                                            return 'Es necesario completar este campo';
                                          } else {
                                            setState(() {
                                              diet = value;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: pet_sociable,
                                        decoration: InputDecoration(
                                          labelText:
                                              "¿Sociable con otros perros?",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            pet_sociable = newValue;
                                          });
                                        },
                                        items: <String>['Sí', 'No']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: kid_sociable,
                                        decoration: InputDecoration(
                                          labelText: "¿Sociable con niños?",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            kid_sociable = newValue;
                                          });
                                        },
                                        items: <String>['Sí', 'No']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: vaccines,
                                        decoration: InputDecoration(
                                          labelText: "¿Vacunas al día?",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            vaccines = newValue;
                                          });
                                        },
                                        items: <String>['Sí', 'No']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: sterilized,
                                        decoration: InputDecoration(
                                          labelText: "¿Está esterilizado?",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            sterilized = newValue;
                                          });
                                        },
                                        items: <String>['Sí', 'No']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      TextFormField(
                                        initialValue: extra_info,
                                        style: TextStyle(color: Colors.black),
                                        //initialValue: "prueba@prueba.com",
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Información adicional',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                          labelText: 'Información adicional',
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
                                      DropdownButtonFormField<String>(
                                        value: size,
                                        decoration: InputDecoration(
                                          labelText: "Tamaño",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            size = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Pequeño',
                                          'Mediano',
                                          'Grande'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: breed,
                                        decoration: InputDecoration(
                                          labelText: "Raza",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            breed = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Chihuahua',
                                          'Ratón de praga',
                                          'Pastor alemán',
                                          'Pug'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: gender,
                                        decoration: InputDecoration(
                                          labelText: "Sexo",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            gender = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Hembra',
                                          'Macho'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(value),
                                            value: value,
                                          );
                                        }).toList(),
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
                                                color: primary_green,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: double.infinity,
                                                  minHeight: 40.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Guardar",
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
