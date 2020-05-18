import 'package:flutter/material.dart';
import 'extras/globals.dart';
import 'partner/home-card.dart';
import 'partner/walker_list.dart';
import 'partner/host_list.dart';
import 'dates/dates.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHome createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Bienvenido, Javier',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image:
                        AssetImage("images/drawer.png"), // <-- BACKGROUND IMAGE
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Mi cuenta'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Pagos'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Cupones'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text('Mis servicios'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Ayuda'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Información legal'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Cerrar sesión'),
                onTap: () {},
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
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(dummy_net_img),
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
                                      image: AssetImage("images/host-btn.png"),
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
                onPressed: () {},
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
