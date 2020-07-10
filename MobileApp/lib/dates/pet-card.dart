import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../extras/globals.dart';

Widget petCard(BuildContext context, controller, pet_data) {
  String pet_name = "N/D";
  String pet_age = "N/D";
  String pet_biography = "N/D";
  String pet_img = pattern;
  String pet_gender = null;

  if (checkJsonArray(context, jsonEncode(pet_data))) {
    print(jsonEncode(pet_data));
    pet_name = pet_data["pet_name"];
    pet_age = pet_data["pet_age"];
    pet_biography = pet_data["pet_biography"];
    pet_img = images_path + pet_data["pet_img_url"];
    pet_gender = pet_data["pet_gender"];
  }

  genderIcon() {
    var icon = Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: pet_gender == 'Hembra' ? Colors.pink : Colors.blue, borderRadius: BorderRadius.circular(50)),
      child: Icon(
        pet_gender == 'Hembra' ?
        FontAwesomeIcons.venus: FontAwesomeIcons.mars,
        color: Colors.white,
      ),
    );



    if (pet_gender == "macho") {
      icon = Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: primary_blue, borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      );
    }

    return icon;
  }

  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.19),
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 1.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            5.0, // Move to bottom 10 Vertically
          ),
        )
      ],
      borderRadius: BorderRadius.circular(big_border_radius),
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: setImage("network", pet_img, true),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(normal_padding),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(big_border_radius),
            gradient: new LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                pet_name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              genderIcon()
            ],
          ),
        )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(normal_padding),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(big_border_radius),
                  gradient: new LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5)
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pet_biography,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mi dueño",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 3,),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(dummy_user_image),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
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
                                    controller.triggerLeft();
                                  },
                                  child: new Container(
                                    width: 50,
                                    height: 50,
                                    child:
                                        Icon(FontAwesomeIcons.times, color: primary_red),
                                  ),
                                ),
                              ),
                            ),
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
                                    controller.triggerRight();
                                  },
                                  child: new Container(
                                    width: 50,
                                    height: 50,
                                    child:
                                        Icon(FontAwesomeIcons.check, color: primary_green),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )))
      ],
    ),
  );
}
