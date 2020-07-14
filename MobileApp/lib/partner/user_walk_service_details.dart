import 'dart:convert';

import 'package:flutter/material.dart';
import '../extras/globals.dart';

Widget profileServiceDetailsCard(BuildContext context, partnerData) {
  String name = "N/D";
  String city = "N/D";
  String description = "N/D";
  String service_price = null;
  String partner_img = pattern;

  if (checkJsonArray(context, jsonEncode(partnerData))) {
    print(jsonEncode(partnerData));
    name = partnerData["name"];
    description = partnerData["description"];
    service_price = partnerData["price"];
    partner_img = partnerData["img_url"];
  }

  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(normal_padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(small_border_radius),
                topRight: Radius.circular(small_border_radius)),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('images/white-bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop)),
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
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/walker-btn.png",
              width: 100,
            ),
            Text(
              "Acerca de los paseos de " + name + ":",
              style: TextStyle(
                  color: common_grey,
                  fontSize: 18,
                  fontWeight: small_title_weight),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: common_grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      Container(
          width: double.infinity,
          padding: EdgeInsets.all(normal_padding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(small_border_radius),
                  bottomLeft: Radius.circular(small_border_radius)),
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
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Costo del servicio: ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(1)),
                child: RichText(
                  text: TextSpan(
                    style: new TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '\$'+service_price,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: '/hora'),
                    ],
                  ),
                ),
              )
            ],
          )),
    ],
  );
}
