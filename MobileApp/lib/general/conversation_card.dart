import 'package:flutter/material.dart';
import '../extras/globals.dart';

Widget conversationListCard(BuildContext context) {
  return Container(
    width: 130,
    padding: EdgeInsets.all(small_padding),
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
          child: CircleAvatar(
            backgroundColor: common_grey,
            radius: 30,
            backgroundImage: NetworkImage(dummy_net_partner),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dummy_partner_name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: title_color,
                            fontWeight: small_title_weight,
                            fontSize: small_title_size),
                      ),
                      Text(
                        "10:04",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: small_padding),
                      width: 1,
                      height: 20,
                      color: Colors.black26,
                    ),
                    Flexible(
                      child: Text(
                          "Vale perfecto! Nos vemos en 2 horas en plaza Averanda.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: small_paragraph_size,
                              color: Colors.black38,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: small_padding,
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              color: primary_blue, borderRadius: BorderRadius.circular(10)),
        )
      ],
    ),
  );
}
