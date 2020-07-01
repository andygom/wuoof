import 'dart:convert';

import 'package:flutter/material.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'review_card.dart';

Widget partnerInfoCard(BuildContext context, partnerData) {
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
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop)),
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
            Text(
              "¿Quién es " + name + "?",
              style: TextStyle(
                  color: common_grey,
                  fontSize: 18,
                  fontWeight: small_title_weight),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              dummy_service_description,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBar(
                ignoreGestures: true,
                initialRating: 4.5,
                itemSize: 19,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: normal_margin),
        child: Text(
          "Lo que los usuarios dicen del servicio de " + name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: common_grey, fontSize: 18, fontWeight: small_title_weight),
        ),
      ),
      Container(
        width: double.infinity,
        height: 120,
        child: ListView.builder(
            itemCount: 20,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return reviewListCard(context, "Paseos");
            }),
      ),
    ],
  );
}
