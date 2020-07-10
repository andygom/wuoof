import 'package:flutter/material.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../extras/globals.dart';

Widget reviewListCard(BuildContext context, data) {
  return Container(
    width: 290,
    margin: EdgeInsets.only(right: 10),
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
          width: 120,
          padding: EdgeInsets.all(small_padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(small_border_radius),
                bottomLeft: Radius.circular(small_border_radius)),
            image: DecorationImage(
              image: NetworkImage(dummy_user_image),
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
                      dummy_user_name,
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
                      itemSize: 18,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.pets,
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
                SizedBox(
                  height: 3,
                ),
                Text('"'+dummy_partner_bio+'""',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
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
  );
}
