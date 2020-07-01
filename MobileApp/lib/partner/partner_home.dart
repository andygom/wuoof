import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/inbox.dart';
import 'package:wuoof/general/main-appbar.dart';
import 'package:wuoof/partner/home_hospedaje_item_card.dart';
import 'package:wuoof/partner/home_host_item_card.dart';
import 'package:wuoof/partner/home_walk_item_card.dart';
import 'package:wuoof/partner/partner_login.dart';
import 'package:wuoof/partner/partner_offered_services.dart';
import 'package:wuoof/partner/partner_payment_details.dart';
import 'package:wuoof/partner/partner_profile.dart';
import '../dates/date_item_card.dart';
import '../partner/walk_item_card.dart';
import '../partner/host_item_card.dart';
import '../wuoof_app_icons_icons.dart';

var categoria_plomeria = "1";
var categoria_electricidad = "2";
var categoria_especiales = "3";

class PartnerHome extends StatefulWidget {
  final int tabIndex;

  PartnerHome(this.tabIndex);
  @override
  _PartnerHome createState() => _PartnerHome();
}

class _PartnerHome extends State<PartnerHome> {
  bool loading_lists = true;
  bool fetch_error = false;
  bool logged = false;

  String mail = null;
  String password = null;
  String user_id = null;

  List<Map<String, dynamic>> listaServicios;
  List<Map<String, dynamic>> serviciosPlomeria;
  List<Map<String, dynamic>> serviciosElectricidad;
  List<Map<String, dynamic>> serviciosEspeciales;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadServicesList(context);
  }

  Future<http.Response> loadServicesList(BuildContext context) async {
    final http.Response response = await http.post(
      'http://balabox-demos.com/fixme/backend/app/mods/mods',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "get_services_list",
        'user_id': "user_IZnaROosy5Y",
        'status': "active"
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(jsonResponse[0]['message'].toString());
      if (jsonResponse[0]['status'] == "true") {
        setState(() {
          loading_lists = false;
          listaServicios =
              List<Map<String, dynamic>>.from(jsonResponse[0]['message']);
          serviciosPlomeria = listaServicios
              .where((service) => service["category_id"] == categoria_plomeria)
              .toList();
          serviciosElectricidad = listaServicios
              .where(
                  (service) => service["category_id"] == categoria_electricidad)
              .toList();
          serviciosEspeciales = listaServicios
              .where(
                  (service) => service["category_id"] == categoria_especiales)
              .toList();
        });
        //print(jsonResponse[0]['message'].toString());
      } else {
        setState(() {
          loading_lists = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        loading_lists = false;
        fetch_error = true;
      });
      _displaySnackBar(context, "No se ha podido cargar la lista de servicios");
      //throw Exception('Failed to load list.');
    }
  }

  _displaySnackBar(context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  showLists(context) {
    return TabBarView(children: [
      fetch_error
          ? null
          : modelListGenerator(
              context, categoria_electricidad, serviciosElectricidad, "walks"),
      modelListGenerator(
          context, categoria_especiales, serviciosEspeciales, "hosts"),
          modelListGenerator(
          context, categoria_especiales, serviciosEspeciales, "hospedaje"),
    ]);
  }

  modelListGenerator(context, category, list, model) {
    var listLength;

    if (category == "") {
      listLength = list.length;
    } else {
      listLength =
          list.where((service) => service["category_id"] == category).length;
    }

    setModel(history) {
      var card_model = dateItemListCard(context, false);

      switch (model) {
        case "walks":
          card_model = homeWalkItemListCard(context, history);
          break;

        case "hosts":
          card_model = homeHostItemListCard(context, history);
          break;
        
        case "hospedaje":
          card_model = homeHospedajeItemListCard(context, history);
          break;
      }

      return card_model;
    }

    return new Padding(
      padding: EdgeInsets.all(small_padding),
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(7),
        crossAxisCount: 1,
        itemCount: listLength,
        itemBuilder: (BuildContext context, int index) => setModel(false),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //loading_lists ? loadServicesList(context) : null;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary_green,
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
                            image: setImage("network", dummy_net_partner,
                                true), // <-- BACKGROUND IMAGE
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    dummy_user_name != null
                        ? "Bienvenido, " + dummy_partner_name
                        : "",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/partner-bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.9), BlendMode.dstATop))),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: primary_green,
              ),
              title: Text('Mi perfil'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PartnerProfile()));
              },
            ),
            ListTile(
              leading: Icon(
                WuoofAppIcons.guidedog,
                color: primary_green,
              ),
              title: Text('Mis servicios'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OfferedServices()));
              },
            ),
            ListTile(
              leading: Icon(
                WuoofAppIcons.iconos_wuoof_tarjetas,
                color: primary_green,
              ),
              title: Text('Datos de pago'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PartnerPaymentDetails()));
              },
            ),
            ListTile(
              leading: Icon(
                WuoofAppIcons.iconos_wuoof_inbox_03__1_,
                color: primary_green,
              ),
              title: Text('Inbox'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Inbox()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PartnerLogin()));
              },
            ),
          ],
        ),
      ),
      body: loading_lists
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : DefaultTabController(
              length: 3,
              initialIndex: widget.tabIndex,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/partner-bg.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.9),
                                  BlendMode.dstATop))),
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
                                                      PartnerProfile()));
                                        },
                                        child: new Container(
                                          width: 40,
                                          height: 40,
                                          child: Icon(Icons.edit,
                                              color: common_grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Modificar",
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
                                    child: CircleAvatar(
                                      backgroundColor: common_grey,
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(dummy_net_partner),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("¡Hola, " + dummy_partner_name,
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
                                                      Inbox()));
                                        },
                                        child: new Container(
                                          width: 40,
                                          height: 40,
                                          child: Icon(Icons.inbox,
                                              color: common_grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Inbox",
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
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Partner: ',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      TextSpan(
                                          text: 'Paseador',
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
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Estado: ',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      TextSpan(
                                          text: 'Cuernavaca, Mor.',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    constraints: BoxConstraints.expand(height: 50),
                    child: TabBar(
                        isScrollable: false,
                        tabs: [
                          Tab(
                             icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/walker-btn.png",
                                width: 30,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Paseos", style: TextStyle(fontSize: 10))
                            ],
                          )),
                          Tab(
                              icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/host-btn.png",
                                width: 30,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Cuidados", style: TextStyle(fontSize: 10))
                            ],
                          )),
                          Tab(
                             icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/hospedaje-btn.png",
                                width: 30,
                              ),
                              /*    SizedBox(
                                width: 4,
                              ), */
                              Text("Hospedajes", style: TextStyle(fontSize: 10)),
                            ],
                          )),
                        ],
                        labelColor: Colors.black,
                        indicatorColor: primary_green),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/white-bg.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.9),
                                  BlendMode.dstATop))),
                      child: !fetch_error ? showLists(context) : null,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
