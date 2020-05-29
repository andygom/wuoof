import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/owner/my_activities.dart';

class Requesting extends StatefulWidget {
  @override
  _Requesting createState() => _Requesting();
}

class _Requesting extends State<Requesting>
    with SingleTickerProviderStateMixin {
  Animation gap;
  Animation base;
  Animation reverse;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    controller.repeat();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => UserActivities(1))));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary_green,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            padding: EdgeInsets.all(normal_padding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(pattern),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
            )),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: RotationTransition(
                    turns: base,
                    child: DashedCircle(
                      gapSize: gap.value,
                      dashes: 20,
                      color: Colors.white,
                      child: RotationTransition(
                        turns: reverse,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundImage: NetworkImage(dummy_net_partner),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Esperando a que " +
                      dummy_partner_name +
                      " responda tu solicitud",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "(Si sales de la aplicación sin cancelar la solicitud, permanecerá activa hasta que el cuidador la acepte)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 200,
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: primary_red,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 40.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Cancelar solicitud",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))));
  }
}
