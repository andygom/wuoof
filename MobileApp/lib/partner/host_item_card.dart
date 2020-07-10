import 'package:flutter/material.dart';
import 'package:wuoof/general/chat.dart';
import '../extras/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'partner_rate.dart';

Widget hostItemListCard(BuildContext context, history) {
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
                transform: Matrix4.translationValues(12.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(dummy_net_partner),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/host-btn.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
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
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dog_dummy_name + " ya tiene cuidador",
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
                  new TextSpan(text: 'Cuidador: ', style: new TextStyle()),
                  new TextSpan(
                      text: dummy_partner_name,
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: SizedBox(
                height: 0.5,
                width: double.infinity,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Detalles de pago:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text('Folio:',
                        style: new TextStyle(
                          fontSize: 13,
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "folio_jcilbv982",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Fecha de pago:',
                        style: new TextStyle(
                          fontSize: 13,
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "15/06/2020 14:20 ",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Tarjeta utilizada: ',
                        style: new TextStyle(
                          fontSize: 13,
                        )),
                    Image.network(
                      card_img,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "**** 4290",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        // SizedBox(
        //   height: 10,
        // ),
        SizedBox(height: 15,),
        InkWell(
          onTap: (){
            rateDialog(context, dummy_partner_name);
          },
                  child: Container(
            child: Text( "Calificar a " + dummy_partner_name,style: TextStyle(fontSize: 17, color: primary_blue),),
          ),
        ),
        SizedBox(height: 10,),
        // RatingBar(
        //   ignoreGestures: false,
        //   initialRating: 4,
        //   itemSize: 35,
        //   minRating: 1,
        //   direction: Axis.horizontal,
        //   allowHalfRating: true,
        //   itemCount: 5,
        //   itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
        //   itemBuilder: (context, _) => Icon(
        //     Icons.star,
        //     color: Colors.amber,
        //   ),
        //   onRatingUpdate: (rating) {
        //     print(rating);
        //   },
        // ),
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
                      "Llamar a " + dummy_partner_name,
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
                            ChatScreen(dummy_partner_name, dummy_net_partner)));
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
