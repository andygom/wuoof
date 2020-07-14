import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/formField.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wuoof/general/main-appbar.dart';
import 'package:wuoof/general/partner-appbar.dart';

class PartnerOfferedHost extends StatefulWidget {
  @override
  _PartnerOfferedHostState createState() => _PartnerOfferedHostState();
}

class _PartnerOfferedHostState extends State<PartnerOfferedHost> {
  bool filling_form = false;
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Asset> images = List<Asset>();
  String _error = 'No hay error';

  String mail = "alex@torres.com";
  String password = "12345678";
  String name = "Alex";
  String dad_lastname = "Morales";
  String mom_lastname = "Torres";
  String city = "Cuernavaca";
  String state = "Morelos";
  String base64_img = "";
  String biography = dummy_partner_bio;
  double price = 250.00;

  bool edition_enabled = false;

  String edit_image = "Toca la foto para cambiarla";
  String cant_edit_image = "Bienvenido Alex";

  String edit_profile = "Editar";
  String update_profile = "Wuoof!";

  File _image;

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
          statusBarColor: "#4fb961",
          actionBarColor: "#4fb961",
          actionBarTitle: "Fotos de mi servicio",
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
    AppBar appBar = partner_appbar(context, "Cuidador");

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
                    image: AssetImage('images/checkout-bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop))),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Hero(
                      tag: 'hostOffered',
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(80),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage("images/cuidador.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Mi servicio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                        RaisedButton(
                                    onPressed: loadAssets,
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
                                          "Fotos de mi servicio",
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
                                                  "Toca agregar imágenes de tu servicio")
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
                                    key: _editProfileForm,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 160.0,
                                          child: SimpleTextField(
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
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: price.toString(),
                                          style: TextStyle(color: Colors.black),
                                          enabled:
                                              edition_enabled ? true : false,
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.attach_money,
                                              color: Colors.green,
                                            ),
                                            hintText: 'Precio',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                            labelText: 'Precio',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
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
                                              return 'Ingresa un Precio';
                                            } else {
                                              setState(() {});
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: small_padding),
                                          margin: EdgeInsets.only(
                                              bottom: small_padding),
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5)),
                                          child: Text(
                                            "Precio recomendado \$250.00 por hora",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
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
