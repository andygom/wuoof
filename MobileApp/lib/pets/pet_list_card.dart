import 'dart:convert';

import 'package:flutter/material.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../user_home.dart';

Widget petListCard(BuildContext context, data, verified, service,) {
  var petData = jsonDecode(data);
  return InkWell(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserHome(data)),
      );
    },
    child: Container(
      width: 130,
      margin: EdgeInsets.only(bottom: 10),
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
          ]),
      child: Row(
        children: <Widget>[
          Container(
            height: 110,
            width: 120,
            padding: EdgeInsets.all(small_padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(small_border_radius),
                  bottomLeft: Radius.circular(small_border_radius)),
              image: DecorationImage(
                image: NetworkImage(dummy_net_img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(normal_padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        petData["name"],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: title_color,
                            fontWeight: small_title_weight,
                            fontSize: small_title_size),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    petData["age"]+" años",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(petData["biography"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: false,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: small_paragraph_size,
                          color: common_grey,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
