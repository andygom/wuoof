import 'package:flutter/material.dart';
import 'package:wuoof/general/chat.dart';
import '../extras/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget dateItemListCard(BuildContext context, history) {
  return Container(
    width: 130,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.only(left: small_padding),
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
          padding: EdgeInsets.all(small_padding),
          child: Row(
            children: <Widget>[
              Container(
                height: 65,
                width: 65,
                padding: EdgeInsets.all(small_padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(dummy_net_img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 65,
                width: 65,
                transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(dummy_pet_img_2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: normal_padding,
                bottom: normal_padding,
                right: normal_padding,
                left: normal_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dog_dummy_name + " y " + dog_dummy_name_2,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.center,
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
                  "Hicieron match",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(small_border_radius),
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
                    ],
                  ),
                  child: new Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    dummy_user_name, dummy_user_image)));
                      },
                      child: new Container(
                        padding: EdgeInsets.all(small_padding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(small_border_radius),
                          color: primary_green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Ir al chat",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
