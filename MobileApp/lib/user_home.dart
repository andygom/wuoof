import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wuoof/partner/hospedaje_list.dart';
import 'package:wuoof/wuoof_app_icons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuoof/pets/new_pet.dart';
import 'extras/globals.dart';
import 'general/view_photo.dart';
import 'partner/home-card.dart';
import 'partner/walker_list.dart';
import 'partner/host_list.dart';
import 'dates/dates.dart';
import 'owner/my_pets.dart';
import 'owner/my_activities.dart';
import 'owner/user_profile.dart';
import 'owner/payment_methods.dart';
import 'general/inbox.dart';
import 'owner/user_login.dart';
import 'pets/edit_pet.dart';
import 'package:http/http.dart' as http;

class UserHome extends StatefulWidget {
  final String pet_data;
  UserHome(this.pet_data);

  @override
  _UserHome createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  var validData = false;
  var decodedArray;

  var user_data = null;
  String user_id = "";
  String user_img;

  String pet_featured_image = placeholder_dog;
  String welcome_line = "¡Hola!";

  String pet_name = "";
  String pet_img_url = "";
  String pet_breed = "";
  String pet_birthdate = "";
  String pet_gender = "";

  List<Map<String, dynamic>> listaServicios2 = [
    {
      "service_id": "service_123456789",
      "category": "1",
      "image":
          "https://thumbs.dreamstime.com/b/el-electricista-en-trabajo-con-las-pinzas-cort%C3%B3-cable-el%C3%A9ctrico-instala-l%C3%A1mparas-casa-los-circuitos-el%C3%A9ctricos-cableado-151886460.jpg",
      "title": "Localización y reparación de cortos eléctricos",
      "description": "Descripción breve del servicio, para el ejemplo.",
    }
  ];

  @override
  void initState() {
    super.initState();
    //loadList(context);
    getStoredData(context);
    setState(() {
      validData = checkJsonArray(context, widget.pet_data);
      if (validData) {
        decodedArray = jsonDecode(widget.pet_data);
        pet_name = decodedArray["pet_name"];
        pet_featured_image = images_path + decodedArray["pet_img_url"];
        pet_gender = decodedArray["pet_gender"];
        pet_breed = decodedArray["pet_breed"];
        welcome_line = "¡Hola " + pet_name + "!";
      }
    });
  }

  getStoredData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_data = (prefs.getString('user_data') ?? null);
    });
    if (user_data != null) {
      user_id = jsonDecode(user_data)["user_id"];
      loadPetList(context, user_id);
    } else {
      //Logout
      print("Logout");
      logout();
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_data');
    prefs.remove('user_id');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  bool loading_walkers_list = true;
  bool loading_host_lists = true;
  bool loading_hotel_list = true;
  bool loading_pets_list = true;
  bool fetch_error = false;
  bool logged = false;

  List<Map<String, dynamic>> listaDePaseadores;
  List<Map<String, dynamic>> listaDeCuidadores;
  List<Map<String, dynamic>> listaDeHospedaje;
  List<Map<String, dynamic>> listaDeMascotas;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<http.Response> loadHotelList(BuildContext context) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_available_partners_list",
        "pet_id": "pet_kzxw5zSiqHF",
        "service_id": "service_cbrM81nTLW4"
      }),
    );

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse);
      if (jsonResponse[0]['status'] == "true") {
        print("Checkpoint");
        setState(() {
          loading_hotel_list = false;
          listaDeHospedaje = List<Map<String, dynamic>>.from(
              jsonResponse[1]['partners_data_list']);
        });
        print(jsonResponse[1]['partners_data_list']);
      } else {
        setState(() {
          loading_hotel_list = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
        //_displaySnackBar(context, "Aún no hay cuidadores disponibles");
      }
    } else {
      setState(() {
        loading_hotel_list = false;
        fetch_error = true;
      });
      _displaySnackBar(context, "No se ha podido cargar la lista de servicios");
      //throw Exception('Failed to load list.');
    }
  }

  Future<http.Response> loadHostList(BuildContext context) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_available_partners_list",
        "pet_id": "pet_kzxw5zSiqHF",
        "service_id": "service_k2wCdG3ZmCe"
      }),
    );

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse);
      if (jsonResponse[0]['status'] == "true") {
        print("Checkpoint");
        setState(() {
          loading_host_lists = false;
          listaDeCuidadores = List<Map<String, dynamic>>.from(
              jsonResponse[1]['partners_data_list']);
        });
        print(jsonResponse[1]['partners_data_list']);
      } else {
        setState(() {
          loading_host_lists = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
        //_displaySnackBar(context, "Aún no hay cuidadores disponibles");
      }
    } else {
      setState(() {
        loading_host_lists = false;
        fetch_error = true;
      });
      _displaySnackBar(context, "No se ha podido cargar la lista de servicios");
      //throw Exception('Failed to load list.');
    }
  }

  Future<http.Response> loadList(BuildContext context) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_available_partners_list",
        "pet_id": "pet_kzxw5zSiqHF",
        "service_id": "service_NEO9Fl2xq9q"
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print(jsonResponse);
      if (jsonResponse[0]['status'] == "true") {
        print("Checkpoint");
        setState(() {
          loading_walkers_list = false;
          listaDePaseadores = List<Map<String, dynamic>>.from(
              jsonResponse[1]['partners_data_list']);
        });
        print(jsonResponse[1]['partners_data_list']);
      } else {
        setState(() {
          loading_walkers_list = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        loading_walkers_list = false;
        fetch_error = true;
      });
      _displaySnackBar(context, "No se ha podido cargar la lista de servicios");
      //throw Exception('Failed to load list.');
    }
  }

  Future<http.Response> loadPetList(BuildContext context, user_id) async {
    final http.Response response = await http.post(
      api_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'action': "get_user_pet_list", 'user_id': user_id}),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(jsonResponse[0]['message']);
      if (jsonResponse[0]['status'] == "true") {
        setState(() {
          loading_pets_list = false;
          listaDeMascotas =
              List<Map<String, dynamic>>.from(jsonResponse[1]['pet_data_list']);
          if (!validData) {
            var first_pet = listaDeMascotas[0];
            pet_name = first_pet["pet_name"];
            pet_featured_image = images_path + first_pet["pet_img_url"];
            pet_gender = first_pet["pet_gender"];
            pet_breed = first_pet["pet_breed"];
            welcome_line = "¡Hola " + pet_name + "!";
          }
        });
        print(jsonResponse[1]['pet_data_list']);
        loadList(context);
        loadHostList(context);
        loadHotelList(context);
      } else {
        setState(() {
          loading_pets_list = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewPet(user_id)),
        );
      }
    } else {
      setState(() {
        loading_pets_list = false;
      });
      _displaySnackBar(
          context, "Hubo un problema, comúnicate con soporte de Wuoof!");
      //throw Exception('Failed to load list.');
    }
  }

  _displaySnackBar(context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primary_yellow,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'images/horizontal_logo_w.png',
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Stack(
                children: <Widget>[
                  new Icon(WuoofAppIcons.iconos_wuoof_inbox_03__1_),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '2',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Inbox()));
              },
            )
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Hero(
                        tag: "profile_picture",
                        child: Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.white),
                            image: DecorationImage(
                              image: setImage("network", dummy_user_image,
                                  true), // <-- BACKGROUND IMAGE
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      dummy_user_name != null
                          ? "Bienvenido, " + dummy_user_name
                          : "",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/PerfilPersona-bg.png'),
                        fit: BoxFit.cover)),
                /* decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [primary_yellow, primary_yellow],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(2.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  image: DecorationImage(
                    image: setImage("network", drawer_bg, true),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ), */
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: primary_green,
                ),
                title: Text('Mi perfil'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.pets,
                  color: primary_green,
                ),
                title: Text('Mis mascotas'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPets(user_id)));
                },
              ),
              ListTile(
                leading: Icon(
                  WuoofAppIcons.iconos_wuoof_actividad,
                  color: primary_green,
                ),
                /* leading: Icon(
                  Icons.book,
                  color: primary_green,
                ),  */
                title: Text('Actividades'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserActivities(0)));
                },
              ),
              ListTile(
                leading: Icon(
                  WuoofAppIcons.iconos_wuoof_tarjetas,
                  color: primary_green,
                ),
                title: Text('Mis tarjetas'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethods()));
                },
              ),
              ListTile(
                leading: Icon(
                  WuoofAppIcons.iconos_wuoof_inbox_03__1_,
                  color: primary_green,
                ),
                title: Text('Inbox'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Inbox()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: primary_green,
                ),
                title: Text('Ayuda'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: primary_green,
                ),
                title: Text('Información legal'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  WuoofAppIcons.iconos_wuoof_cerrarsesio_n,
                  color: primary_green,
                ),
                title: Text('Cerrar sesión'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                /* decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("images/PerfilMascota-bg.png"),
                  ),
                ), */
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/PerfilMascota-bg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop))),
                /* decoration: BoxDecoration(
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
                ), */
                padding: EdgeInsets.all(normal_padding),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
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
                              child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserActivities(0)));
                                  },
                                  child: new Container(
                                    width: 40,
                                    height: 40,
                                    child: Icon(Icons.pets, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Actividad",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Card(
                              elevation: 5.0,
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () {
                                  photoView(context, 'dog',pet_featured_image, primary_yellow, 'DogPhoto', user_id);
                                },
                                child: Hero(
                                  placeholderBuilder: (context, Size, child) {
                                    return CircleAvatar(
                                      backgroundColor: common_grey,
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(pet_featured_image),
                                    );
                                  },
                                  tag: 'DogPhoto',
                                  child: CircleAvatar(
                                    backgroundColor: common_grey,
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(pet_featured_image),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(welcome_line,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
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
                              child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyPets(user_id)));
                                  },
                                  child: new Container(
                                    width: 40,
                                    height: 40,
                                    child: Icon(Icons.swap_horiz,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Cambiar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Wrap(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: Colors.black,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.top,
                                  child: Icon(FontAwesomeIcons.dog,
                                      color: Colors.white, size: 15),
                                ),
                                TextSpan(
                                    text: ' Raza: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: pet_breed,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 1,
                            height: 20,
                            color: Colors.white,
                          ),
                          RichText(
                            text: TextSpan(
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: Colors.black,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.top,
                                  child: Icon(
                                      pet_gender == 'Hembra'
                                          ? FontAwesomeIcons.venus
                                          : FontAwesomeIcons.mars,
                                      color: Colors.white,
                                      size: 15),
                                ),
                                TextSpan(
                                    text: 'Género: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: pet_gender,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                          /* Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 1,
                            height: 20,
                            color: Colors.white,
                          ),
                          RichText(
                            text: TextSpan(
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Edad: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: '2',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ), */
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/white-bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop))),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                    child: SizedBox(
                      height: 0.5,
                      width: double.infinity,
                    ),
                  ),

// BOTONES DE SERVICIOS

                  Container(
                    padding: EdgeInsets.symmetric(vertical: normal_padding),
                    width: double.infinity,
                    height: 150,
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        botonServicio(
                            context,
                            "date-badge",
                            "Citas",
                            "images/date-btn.png",
                            DatesScreen(widget.pet_data)),
                        botonServicio(context, "host-badge", "Cuidador",
                            "images/host-btn.png", HostList()),
                        botonServicio(context, "walker-badge", "Paseadores",
                            "images/walker-btn.png", WalkerList()),
                        botonServicio(context, "hosp-badge", "Hospedaje",
                            "images/hospedaje-btn.png", HospedajeList()),
                      ],
                    ),
                  ),
// SERVICE
                  SizedBox(
                    height: 5,
                  ),
                  serviceCards(
                      context,
                      "images/walker-btn.png",
                      'paseo',
                      'paseador',
                      loading_walkers_list,
                      listaDePaseadores,
                      WalkerList()),
                  SizedBox(height: 5),
                  serviceCards(
                      context,
                      "images/host-btn.png",
                      'host',
                      'cuidador',
                      loading_host_lists,
                      listaDeCuidadores,
                      HostList()),
                  SizedBox(height: 5),
                  serviceCards(
                      context,
                      "images/hospedaje-btn.png",
                      'hotel',
                      'hospedaje',
                      loading_hotel_list,
                      listaDeHospedaje,
                      HospedajeList()),
                ],
              ),
            ),
          ],
        ));
  }
}

Widget botonServicio(
    context, herotag, textService, imageservice, navigationService) {
  double size = (imageservice == "images/hospedaje-btn.png") ? 55 : 60;
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: small_padding, vertical: small_padding),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(small_border_radius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => navigationService));
          },
          child: new Container(
            width:
                (MediaQuery.of(context).size.width / 3) - (normal_padding) - 5,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: herotag,
                  child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(imageservice),
                        ),
                      )),
                ),
                SizedBox(height: 5),
                Text(textService)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget serviceCards(context, servicioIcon, servicio, serviciofound,
    loading_list, listaDePartners, servicePage) {
  double size = (servicioIcon == "images/hospedaje-btn.png") ? 25 : 30;
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(servicioIcon),
                ),
              )),
          SizedBox(width: 5),
          Text("Encuentra a tu ${serviciofound} ideal",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: common_grey))
        ],
      ),
      Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            child: loading_list
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ))
                : listaDePartners == null
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.white,
                        child: Center(
                          child: Text("¡No se encontraron resultados!"),
                        ))
                    : ListView.builder(
                        itemCount: listaDePartners.length,
                        padding: EdgeInsets.all(normal_padding),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return partnerHomeCard(
                              context, listaDePartners[index], servicio, payService);
                        }),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: normal_padding),
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => servicePage));
              },
              color: Colors.green,
              child: Text(
                "Ver todos",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
