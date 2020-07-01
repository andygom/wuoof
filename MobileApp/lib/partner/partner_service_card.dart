import 'dart:convert';

import 'package:flutter/material.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../partner/public_partner_profile.dart';

Widget partnerServiceCard(BuildContext context, service, service_price) {

  String service_name;
  String service_image;
  String service_description;

  if(service == "host"){
    service_name = "Cuidador";
    service_image = "images/cuidador.png";
    service_description = dummy_partner_bio;
  }  else if (service == "walk" ){
    service_name = "Paseador";
    service_image = "images/paseador.png";
    service_description = dummy_service_description;
  }
   else if (service == "hospedaje" ){
    service_name = "Hospedaje";
    service_image = "images/hospedaje.png";
    service_description = dummy_service_description;
  }

  return Container(
    child: InkWell(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: normal_margin),
        padding: EdgeInsets.all(normal_padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(medium_border_radius),
          color: Colors.white,
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(service_name,
                      style: TextStyle(
                          color: primary_green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    (service_description),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(1)),
                  child: RichText(
                    text: TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\$'+service_price,
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: '/evento'),
                      ],
                    ),
                  ),
                )
                ],
              ),
            ),
            SizedBox(width: normal_margin),
            Container(
                child: Image.asset(service_image),
                height: 100,
                alignment: Alignment.topRight),
          ],
        ),
      ),
      onTap: () {
      },
    ),
  );
}
