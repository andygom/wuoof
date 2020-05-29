import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wuoof/dates/dates.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/partner/partner_profile.dart';
import 'package:wuoof/partner/walker_list.dart';
import '../extras/globals.dart';
import 'home-card.dart';
import 'host_list.dart';

class PartnerHome extends StatefulWidget {
  @override
  _PartnerHome createState() => _PartnerHome();
}

class _PartnerHome extends State<PartnerHome> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primary_green,
          title: Row(
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
                  Icons.star,
                  color: primary_green,
                ),
                title: Text('Mis servicios'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: primary_green,
                ),
                title: Text('Datos de pago'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: primary_green,
                ),
                title: Text('Inbox'),
                onTap: () {},
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
                  Icons.exit_to_app,
                  color: primary_green,
                ),
                title: Text('Cerrar sesión'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                color: primary_green,
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
                                  onTap: () {},
                                  child: new Container(
                                    width: 40,
                                    height: 40,
                                    child: Icon(Icons.edit, color: common_grey),
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
                                  onTap: () {},
                                  child: new Container(
                                    width: 40,
                                    height: 40,
                                    child:
                                        Icon(Icons.inbox, color: common_grey),
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
                                    style: TextStyle(color: Colors.white)),
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
                                    style: TextStyle(color: Colors.white)),
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
            DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                   Container(
                    constraints: BoxConstraints.expand(height: 50),
                    child: TabBar(
                        isScrollable: false,
                        tabs: [
                          Tab(
                              icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/host-btn.png",
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Cuidados")
                            ],
                          )),
                          Tab(
                              icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/walker-btn.png",
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Paseos")
                            ],
                          )),
                        ],
                        labelColor: Colors.black,
                        indicatorColor: primary_green),
                        
                   ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}