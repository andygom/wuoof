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
import 'package:http/http.dart' as http;
import 'package:wuoof/owner/my_pets.dart';

class NewPet extends StatefulWidget {
  final String user_id;
  NewPet(this.user_id);

  @override
  _NewPet createState() => _NewPet();
}

class _NewPet extends State<NewPet> {
  bool filling_form = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String dummy = "hey";

  List<Asset> images = List<Asset>();
  String _error = 'No hay error';

  List _myActivities;
  String _myActivitiesResult;

  @override
  void initState() {
    super.initState();
    _myActivities = ["Amigable", "Obediente", "Travieso"];
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

  Future<void> printIt() async {
    //ByteData byteData = await asset.getByteData(quality: 80);
    ByteData byteData = await images[0].getByteData(quality: 80);
    //print(base64Encode(byteData.buffer.asUint16List()));
    setState(() {
      //dummy = base64Encode(byteData.buffer.asUint8List());
    });
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

  _saveForm() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  String pet_name = "Bambina";
  String profile_pic_base64 = "";
  String nationality = "Mexicana";
  String birth_date = "12/11/2017";
  String biography =
      "Soy una perrita muy tranquila, me gusta jugar con más perros.";
  String allergies_and_treatment = "Tengo alergia a las croquetas Dog Chow";
  String training = "Va al baño y atiende a las órdenes de comida.";
  String diet = "Come pollo con arroz todos los días.";
  String pet_sociable = "Sí";
  String kid_sociable = "Sí";
  String vaccines = "Sí";
  String sterilized = "Sí";
  String extra_info = "Come dos veces al día, a las 11:00 am y a las 4:00 pm";
  String size = "Pequeño";
  String breed = "Chihuahua";
  String gender = "Hembra";

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 700,
        maxHeight: 700);

    setState(() {
      _image = image;
      profile_pic_base64 = base64Encode(_image.readAsBytesSync());
    });
    //print(base64Encode(_image.readAsBytesSync()));
  }

  Future<http.Response> submitForm(context) async {
    setState(() {
      filling_form = true;
    });

    try {
      final http.Response response = await http.post(
        api_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "action": "new_pet",
          "user_id": widget.user_id,
          "name": pet_name,
          "img_url": profile_pic_base64,
          "img_url_gallery": ([
            "assets/welcome0.png",
            "assets/welcome1.png",
            "assets/welcome2.png",
            "assets/welcome2.png",
            "assets/welcome1.png",
            "assets/welcome1.png"
          ]).toString(),
          "age": birth_date,
          "gender": gender,
          "nationality": nationality,
          "breed": breed,
          "biography": biography,
          "information": extra_info,
          "personality": _myActivities.toString()
        }),
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        print("checkpoint");
        if (jsonResponse[0]['status'] == "true") {
          print("bingo");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MyPets(widget.user_id)));
        } else {
          print("nah");
          setState(() {
            filling_form = false;
          });
          _displaySnackBar(context, jsonResponse[0]['message'].toString());
        }
      } else {
        setState(() {
          filling_form = false;
        });
        _displaySnackBar(context,
            "No se ha podido registrar tu cuenta, revisa tu conexión a internet.");
        throw Exception('Failed to signup.');
      }
    } catch (e) {
      _displaySnackBar(
          context, "Parece que hay un problema, contacta a soporte.");
    }
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Nueva mascota");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      key: _scaffoldKey,
      body: filling_form
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : Column(
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
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.9),
                              BlendMode.dstATop))),
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
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  image: DecorationImage(
                                    image: _image == null
                                        ? NetworkImage(placeholder_dog)
                                        : FileImage(
                                            _image), // <-- BACKGROUND IMAGE
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
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/white-bg.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.dstATop))),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: loadAssets,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      color: primary_green,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 40.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Fotos de mi mascota",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 300,
                                height: 100,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black12,
                                ),
                                child: images.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.photo_library),
                                          Text(
                                              "Toca agregar imágenes de tu mascota")
                                        ],
                                      )
                                    : Align(
                                        child: buildGridView(),
                                      ),
                              ),
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
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                maxLength: null,
                                                icon: Icons.pets,
                                                label: 'petName',
                                                labelText: 'Nombre',
                                                onSaved: (input) =>
                                                    pet_name = input,
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                label: 'nationality',
                                                // maxLength: null,
                                                icon: Icons.pets,
                                                helperText: '',
                                                labelText: 'Nacionalidad',
                                                onSaved: (input) =>
                                                    nationality = input,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                padding: EdgeInsets.all(
                                                    small_padding),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            small_border_radius)),
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                            "Fecha de nacimiento"),
                                                        Text(
                                                          '02/08/20',
                                                          // birthdate_string.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  common_grey,
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                label: 'bio',
                                                maxLength: 150,
                                                maxLines: 5,
                                                icon: Icons.pets,
                                                helperText: '',
                                                labelText: 'Biografía',
                                                onSaved: (input) =>
                                                    biography = input,
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                label: 'train',
                                                maxLength: 50,
                                                maxLines: 2,
                                                icon: Icons.pets,
                                                helperText: '',
                                                labelText: 'Entrenamiento',
                                                onSaved: (input) =>
                                                    training = input,
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                label: 'diet',
                                                maxLength: 50,
                                                maxLines: 2,
                                                icon: Icons.pets,
                                                helperText: '',
                                                labelText: 'Dieta',
                                                onSaved: (input) =>
                                                    diet = input,
                                              ),
                                              DropDownField(
                                                labelText:
                                                    '¿Sociable con otros perros?',
                                                itemsList: <String>[
                                                  'Si',
                                                  'No'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                enabled: true,
                                                onChanged: (input) =>
                                                    pet_sociable = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText:
                                                    '¿Sociable con otros perros?',
                                                itemsList: <String>[
                                                  'Si',
                                                  'No'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    pet_sociable = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText:
                                                    '¿Sociable con niños?',
                                                itemsList: <String>[
                                                  'Si',
                                                  'No'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    kid_sociable = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText: '¿Vacunas al día?',
                                                itemsList: <String>[
                                                  'Si',
                                                  'No'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    vaccines = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText:
                                                    '¿Está esterilizado?',
                                                itemsList: <String>[
                                                  'Si',
                                                  'No'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    sterilized = input,
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                label: 'extra',
                                                maxLength: 50,
                                                maxLines: 2,
                                                icon: Icons.pets,
                                                helperText: '',
                                                labelText:
                                                    'Información adicional',
                                                onSaved: (input) =>
                                                    extra_info = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText: 'Tamaño',
                                                itemsList: <String>[
                                                  'Pequeño',
                                                  'Mediano',
                                                  'Grande'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    size = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText: 'Raza',
                                                itemsList: <String>[
                                                  'Chihuahua',
                                                  'Ratón de praga',
                                                  'Pastor alemán',
                                                  'Pug'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    breed = input,
                                              ),
                                              DropDownField(
                                                enabled: true,
                                                labelText: 'Sexo',
                                                itemsList: <String>[
                                                  'Hembra',
                                                  'Macho'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(value),
                                                    value: value,
                                                  );
                                                }).toList(),
                                                onChanged: (input) =>
                                                    gender = input,
                                              ),
                                              MultiSelectFormField(
                                                autovalidate: false,
                                                titleText:
                                                    '¿Cómo es tu mascota?',
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
                                                    "display":
                                                        "Líder de la manada",
                                                    "value":
                                                        "Líder de la manada",
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
                                                onSaved: (value) {
                                                  if (value == null) return;
                                                  setState(() {
                                                    _myActivities = value;
                                                  });
                                                },
                                              ),
                                              SimpleTextField(
                                                enabled: true,
                                                textCapitalization:
                                                    TextCapitalization.none,
                                                maxLines: 1,
                                                label: 'passwordConfirm',
                                                helperText: '',
                                                labelText: 'Contraseña',
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20, bottom: 5),
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    //printIt();
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      profile_pic_base64 !=
                                                                  null &&
                                                              profile_pic_base64 !=
                                                                  ""
                                                          ? submitForm(context)
                                                          : _displaySnackBar(
                                                              context,
                                                              "Grrr, falta la foto!");
                                                    }
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                        color: primary_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: double
                                                                  .infinity,
                                                              minHeight: 40.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Wuoof!",
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
                                                    color: Colors.black
                                                        .withOpacity(0.5),
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
