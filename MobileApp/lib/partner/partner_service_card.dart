import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wuoof/partner/partner_offeredHost.dart';
import 'package:wuoof/partner/partner_offeredHotel.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../partner/public_partner_profile.dart';
import 'partner_offeredWalk.dart';

Widget partnerServiceCard(BuildContext context, service, service_price) {
  String service_name;
  String service_image;
  String service_description;
  String serviceOfferedTag;
  String payConcept;
  Widget service_route;

  if (service == "host") {
    payConcept = payHost;
    service_name = "Cuidador";
    service_image = "images/cuidador.png";
    serviceOfferedTag = "hostOffered";
    service_description = "Toca para editar la información de tu servicio.";
    service_route = PartnerOfferedHost();
  } else if (service == "walk") {
    payConcept = payWalk;
    service_name = "Paseador";
    service_image = "images/paseador.png";
    serviceOfferedTag = "walkOffered";
    service_description = "Toca para editar la información de tu servicio.";
    service_route = PartnerOfferedWalk();
  } else if (service == "hospedaje") {
    payConcept = payHotel;
    service_name = "Hospedaje";
    service_image = "images/hospedaje.png";
    serviceOfferedTag = "hotelOffered";
    service_description = "Toca para editar la información de tu servicio.";
    service_route = PartnerOfferedHotel();
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
                              text: '\$' + service_price,
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(text: '/$payConcept'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: normal_margin),
            Hero(
              tag: serviceOfferedTag,
              child: Container(
                  child: Image.asset(service_image),
                  height: service == "hospedaje" ? 90 : 100,
                  alignment: Alignment.topRight),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => service_route));
      },
    ),
  );
}
