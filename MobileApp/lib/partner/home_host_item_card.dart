import 'package:flutter/material.dart';
import 'package:wuoof/general/chat.dart';
import 'package:wuoof/pets/pet_profile.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget homeHostItemListCard(BuildContext context, history) {
  return Container(
    width: 130,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(normal_padding),
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
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(small_padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(dummy_user_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PetProfile("")));
                },
                child: Container(
                height: 100,
                width: 100,
                transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(dummy_net_img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dog_dummy_name + " se quedará contigo",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: small_title_weight,
                  fontSize: 19),
            ),
            SizedBox(
              height: 2,
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                ),
                children: [
                  new TextSpan(text: 'Dueño: ', style: new TextStyle()),
                  new TextSpan(
                      text: dummy_user_name,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: primary_green)),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                ),
                children: [
                  new TextSpan(
                      text: 'Cuidado programado para: ',
                      style: new TextStyle()),
                  new TextSpan(
                      text: "12 de Noviembre 2020",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: primary_green)),
                ],
              ),
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                ),
                children: [
                  new TextSpan(
                      text: '¿Cuántos días/noches?: ', style: new TextStyle()),
                  new TextSpan(
                      text: "3",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: primary_green)),
                ],
              ),
            ),
            
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(bottom: small_padding),
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
              onTap: () {},
              child: new Container(
                padding: EdgeInsets.all(small_padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(small_border_radius),
                  color: primary_yellow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Llamar a " + dummy_user_name,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        builder: (context) =>
                            ChatScreen(dummy_user_name, dummy_user_image)));
              },
              child: new Container(
                padding: EdgeInsets.all(small_padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(small_border_radius),
                  color: primary_green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Ir al chat",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
