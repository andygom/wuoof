import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/chat.dart';
import 'package:wuoof/general/partner-appbar.dart';
import 'package:wuoof/pets/pet_profile.dart';

import 'home-card.dart';

class PartnerReview extends StatefulWidget {
  PartnerReview({Key key}) : super(key: key);

  @override
  _PartnerReviewState createState() => _PartnerReviewState();
}

class _PartnerReviewState extends State<PartnerReview> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = partner_appbar(context, "Mis reviews");

    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/white-bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop))),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ]),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: common_grey,
                    radius: 30,
                    backgroundImage: NetworkImage(dummy_net_partner),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.pets,
                                size: 20, color: Colors.black.withOpacity(0.5)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                          ]),
                    ),
                  ),
                  // Text('Mi promedio'),
                  SizedBox(
                    height: 5,
                  ),
                  /* RatingBar(
                    ignoreGestures: true,
                    initialRating: 5,
                    itemSize: 25,
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
                  ), */
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  crossAxisCount: 1,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) =>
                      reviewCard(context),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget reviewCard(BuildContext context) {
  // double size = (servicioIcon == "images/hospedaje-btn.png") ? 25 : 30;
  return Column(children: <Widget>[
    Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: 160,
          child: Container(
            width: 130,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(small_padding),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 120,
                        padding: EdgeInsets.all(65),
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
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0.5),
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
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/host-btn.png",
                                        width: 17,
                                      ),
                                      SizedBox(
                                        width: 0,
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text("Cuidado",
                                              style: TextStyle(
                                                fontSize: small_paragraph_size,
                                                color: common_grey,
                                              ))),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('10/08/2020',
                                      style: TextStyle(
                                        fontSize: small_paragraph_size,
                                        color: common_grey,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('"' + dummy_partner_bio + '""',
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
                ]),
          ))
    ])
  ]);
}
