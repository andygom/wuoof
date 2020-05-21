import 'package:flutter/material.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../partner/public_partner_profile.dart';

Widget partnerHomeCard(BuildContext context, service) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PublicPartnerProfile("walk")),
      );
    },
    child: Container(
      width: 130,
      margin: EdgeInsets.only(right: normal_margin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(small_border_radius),
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
          ]),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(small_border_radius),
                  topRight: Radius.circular(small_border_radius)),
              image: DecorationImage(
                image: NetworkImage(dummy_net_partner),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(small_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                    SizedBox(
                      width: 7,
                    ),
                    RatingBar(
                      ignoreGestures: true,
                      initialRating: 4.5,
                      itemSize: 14,
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
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Cuernavaca, Mor.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(dummy_partner_bio,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: false,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: small_paragraph_size,
                        color: common_grey,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 5,
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
                            text: '\$200',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: '/paseo'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
