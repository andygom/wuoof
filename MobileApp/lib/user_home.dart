import 'dart:convert';

import 'package:flutter/material.dart';
import 'extras/globals.dart';
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

class UserHome extends StatefulWidget {
  @override
  _UserHome createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
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
          backgroundColor: primary_yellow,
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
          actions: <Widget>[
            // action button
            IconButton(
              icon: Stack(
                children: <Widget>[
                  new Icon(Icons.inbox),
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
              onPressed: () {},
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
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: primary_green,
                ),
                title: Text('Mi perfil'),
                onTap: () {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPets()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: primary_green,
                ),
                title: Text('Actividades'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserActivities()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: primary_green,
                ),
                title: Text('Mis tarjetas'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethods()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: primary_green,
                ),
                title: Text('Inbox'),
                onTap: () {
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
                  Icons.exit_to_app,
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
                color: primary_yellow,
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
                                backgroundImage: NetworkImage(dummy_net_img),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("¡Hola, Bambina!",
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
                                    child: Icon(Icons.swap_horiz,
                                        color: common_grey),
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
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Raza: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: 'Chihuahua',
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
                                    text: 'Personalidad: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: 'Amigable',
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
                                    text: 'Edad: ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: '2',
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
              width: double.infinity,
              padding: EdgeInsets.all(normal_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HostList()));
                        },
                        child: new Container(
                          width: (MediaQuery.of(context).size.width / 3) -
                              (normal_padding) -
                              5,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: "host-badge",
                                child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image:
                                            AssetImage("images/host-btn.png"),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Text("Cuidadores")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalkerList()));
                        },
                        child: new Container(
                          width: (MediaQuery.of(context).size.width / 3) -
                              (normal_padding) -
                              5,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: "walker-badge",
                                child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image:
                                            AssetImage("images/paseador.png"),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Text("Paseadores")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DatesScreen()));
                        },
                        child: new Container(
                          width: (MediaQuery.of(context).size.width / 3) -
                              (normal_padding) -
                              5,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage("images/date-btn.png"),
                                    ),
                                  )),
                              SizedBox(height: 5),
                              Text("Citas")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: SizedBox(
                height: 0.5,
                width: double.infinity,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Text("Encuentra a tu paseador ideal",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: common_grey)),
                Container(
                  width: double.infinity,
                  height: 240,
                  child: ListView.builder(
                      itemCount: 20,
                      padding: EdgeInsets.all(normal_padding),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return partnerHomeCard(context);
                      }),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: normal_padding),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WalkerList()));
                },
                color: Colors.green,
                child: Text(
                  "Ver todos",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
