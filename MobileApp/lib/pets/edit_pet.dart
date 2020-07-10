import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuoof/extras/globals.dart';
import 'dart:io';
import 'dart:convert';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wuoof/general/formField.dart';
import 'package:wuoof/general/main-appbar.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:wuoof/general/validation.dart';

class EditPet extends StatefulWidget {
  @override
  _EditPet createState() => _EditPet();
}

class _EditPet extends State<EditPet> {
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // //keys form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  // final _nationalityFieldKey = GlobalKey<FormFieldState<String>>();
  // final _birthDayFieldKey = GlobalKey<FormFieldState<String>>();
  // final _biographyFieldKey = GlobalKey<FormFieldState<String>>();
  // final _alergiaFieldKey = GlobalKey<FormFieldState<String>>();
  // final _trainFieldKey = GlobalKey<FormFieldState<String>>();
  // final _dietFieldKey = GlobalKey<FormFieldState<String>>();
  // final _aditionalFieldKey = GlobalKey<FormFieldState<String>>();

  bool edition_enabled = false;
  String edit_image = "Toca la foto para cambiarla";
  String cant_edit_image = "Perfil de Bambina";

  List<Asset> images = List<Asset>();
  String _error = 'No hay error';

  List _myActivities;
  String _myActivitiesResult;

  @override
  void initState() {
    super.initState();
    _myActivities = ["Juguetón", "Travieso", "Amigable"];
    _myActivitiesResult = '';
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      childAspectRatio: 1,
      mainAxisSpacing: 5.0,
      padding: EdgeInsets.all(0),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 200,
          height: 200,
        );
      }),
    );
  }

  Future<void> printIt(asset) async {
    //ByteData byteData = await asset.getByteData(quality: 80);
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      //ByteData byteData = await images[0].getByteData(quality: 80);
      print("Hey");
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  String pet_name = dog_dummy_name;
  String profile_pic_base64 = "";
  String nationality = "Mexicana";
  String birth_date = "23 de Febrero de 2015";
  String biography = dummy_dog_bio;
  String allergies_and_treatment = "Es alérgico a las croquetas de DogChow";
  String training = "Sabe ir al baño";
  String diet = "Le gusta comer pollo con arroz";
  String pet_sociable = "Si";
  String kid_sociable = "Si";
  String vaccines = "Si";
  String sterilized = "Si";
  String extra_info = "Tiene una patita lastimada porque una vez se cayó.";
  String size = "Pequeño";
  String breed = "Chihuahua";
  String gender = "Hembra";

  String edit_profile = "Editar";
  String update_profile = "Wuoof!";

  DateTime birthdate = DateTime.now();
  String birthdate_string =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

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

  Future onSaved(nwvalue) {
    setState(() {
      nwvalue = pet_name;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        fieldLabelText: 'Ingresa la fecha',
        locale: const Locale("es", "MX"),
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

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Editar mascota");

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
                    image: AssetImage('images/PerfilMascota-bg.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: edition_enabled ? getImage : () {},
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
                              Colors.black.withOpacity(0.5),
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
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.words,
                                          maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: pet_name,
                                          icon: Icons.pets,
                                          label: 'petName',
                                          labelText: 'Nombre',
                                          onSaved: (input) => pet_name = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.words,
                                          label: 'nationality',
                                          // maxLength: null,
                                          enabled: edition_enabled,
                                          initValue: nationality,
                                          icon: Icons.pets,
                                          helperText: '',
                                          labelText: 'Nacionalidad',
                                          onSaved: (input) =>
                                              nationality = input,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: 15),
                                          padding:
                                              EdgeInsets.all(small_padding),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      small_border_radius)),
                                          child: InkWell(
                                              onTap: () {
                                                if (edition_enabled == true) {
                                                  _selectDate(context);
                                                } else {}
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
                                          textCapitalization: TextCapitalization.sentences,
                                          label: 'bio',
                                          initValue: biography,
                                          maxLength: 150,
                                          maxLines: 5,
                                          enabled: edition_enabled,
                                          icon: Icons.pets,
                                          helperText: '',
                                          labelText: 'Biografía',
                                          onSaved: (input) => biography = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          label: 'train',
                                          initValue: training,
                                          maxLength: 50,
                                          maxLines: 2,
                                          enabled: edition_enabled,
                                          icon: Icons.pets,
                                          helperText: '',
                                          labelText: 'Entrenamiento',
                                          onSaved: (input) => training = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          label: 'diet',
                                          maxLength: 50,
                                          initValue: diet,
                                          maxLines: 2,
                                          enabled: edition_enabled,
                                          icon: Icons.pets,
                                          helperText: '',
                                          labelText: 'Dieta',
                                          onSaved: (input) => diet = input,
                                        ),
                                        DropDownField(
                                          initValue: pet_sociable,
                                          labelText:
                                              '¿Sociable con otros perros?',
                                          itemsList: <String>['Si', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          enabled: edition_enabled,
                                          onChanged: (input) =>
                                              pet_sociable = input,
                                        ),
                                        DropDownField(
                                          initValue: kid_sociable,
                                          labelText: '¿Sociable con niños?',
                                          itemsList: <String>['Si', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          enabled: edition_enabled,
                                          onChanged: (input) =>
                                              kid_sociable = input,
                                        ),
                                        DropDownField(
                                          initValue: vaccines,
                                          labelText: '¿Vacunas al día?',
                                          itemsList: <String>['Si', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          enabled: edition_enabled,
                                          onChanged: (input) =>
                                              vaccines = input,
                                        ),
                                        DropDownField(
                                          initValue: sterilized,
                                          labelText: '¿Está esterilizado?',
                                          itemsList: <String>['Si', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          enabled: edition_enabled,
                                          onChanged: (input) =>
                                              sterilized = input,
                                        ),
                                        SimpleTextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          initValue: extra_info,
                                          label: 'extra',
                                          maxLength: 50,
                                          maxLines: 2,
                                          enabled: edition_enabled,
                                          icon: Icons.pets,
                                          helperText: '',
                                          labelText: 'Información adicional',
                                          onSaved: (input) =>
                                              extra_info = input,
                                        ),
                                        DropDownField(
                                          initValue: size,
                                          labelText: 'Tamaño',
                                          itemsList: <String>[
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
                                          enabled: edition_enabled,
                                          onChanged: (input) => size = input,
                                        ),
                                        DropDownField(
                                          initValue: breed,
                                          labelText: 'Raza',
                                          itemsList: <String>[
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
                                          enabled: edition_enabled,
                                          onChanged: (input) => breed = input,
                                        ),
                                        DropDownField(
                                          initValue: gender,
                                          labelText: 'Sexo',
                                          itemsList: <String>['Hembra', 'Macho']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          enabled: edition_enabled,
                                          onChanged: (input) => gender = input,
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              edition_enabled ? false : true,
                                          child: MultiSelectFormField(
                                            autovalidate: false,
                                            titleText: '¿Cómo es tu mascota?',
                                            validator: (value) {
                                              if (value == null ||
                                                  value.length == 0) {
                                                return 'Debes escoger al menos una opción';
                                              }
                                              return null;
                                            },
                                            dataSource: [
                                              {
                                                "display": "Amigable",
                                                "value": "Amigable",
                                              },
                                              {
                                                "display": "Juguetón",
                                                "value": "Juguetón",
                                              },
                                              {
                                                "display": "Travieso",
                                                "value": "Travieso",
                                              },
                                              {
                                                "display": "Reservado",
                                                "value": "Reservado",
                                              },
                                              {
                                                "display": "Tranquilo",
                                                "value": "Tranquilo",
                                              },
                                              {
                                                "display": "Solitario",
                                                "value": "Solitario",
                                              },
                                              {
                                                "display": "Obediente",
                                                "value": "Obediente",
                                              },
                                              {
                                                "display": "Territorial",
                                                "value": "Territorial",
                                              },
                                              {
                                                "display":
                                                    "Dominante con otros perros",
                                                "value":
                                                    "Dominante con otros perros",
                                              },
                                              {
                                                "display": "Líder de la manada",
                                                "value": "Líder de la manada",
                                              },
                                              {
                                                "display": "Activo",
                                                "value": "Activo",
                                              },
                                              {
                                                "display": "Pasivo",
                                                "value": "Pasivo",
                                              },
                                            ],
                                            textField: 'display',
                                            valueField: 'value',
                                            okButtonLabel: 'Wuoof!',
                                            cancelButtonLabel: 'Grrr!',
                                            errorText:
                                                "Debes escoger al menos una opción",
                                            // required: true,
                                            hintText:
                                                'Escoge las características',
                                            initialValue: _myActivities,
                                            onSaved: (value) {
                                              if (value == null) return;
                                              setState(() {
                                                _myActivities = value;
                                              });
                                            },
                                          ),
                                        ),
                                        edition_enabled
                                            ? SimpleTextField(
                                              textCapitalization: TextCapitalization.none,
                                                maxLines: 1,
                                                label: 'passwordConfirm',
                                                enabled: edition_enabled,
                                                helperText: '',
                                                labelText: 'Contraseña',
                                              )
                                            : Container(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 5),
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (edition_enabled) {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  print(
                                                      'petName: $pet_name, Nationality: $nationality, TEST: $kid_sociable');
                                                }
                                              } else {
                                                setState(() {
                                                  edition_enabled = true;
                                                });
                                                print(
                                                    'petName: $pet_name, Nationality: $nationality, TEST: $kid_sociable');
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
