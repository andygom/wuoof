import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/owner/my_activities.dart';
import 'package:wuoof/owner/my_pets.dart';
import 'package:wuoof/partner/partner_offered_services.dart';
import 'package:wuoof/partner/partner_profile.dart';
import 'package:wuoof/pets/edit_pet.dart';
import 'package:wuoof/wuoof_app_icons_icons.dart';

import 'inbox.dart';

Future<String> photoView(BuildContext context, String photoType, photo,
    Color colorTheme, String profileTag, String user_id) async {
  double _scale = 5.0;
  double _previousScale = null;

  return Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, _, __) {
        return GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            print(details);
            // Does this need to go into setState, too?
            // We are only saving the scale from before the zooming started
            // for later - this does not affect the rendering...
            _previousScale = _scale;
          },
          onScaleEnd: (ScaleEndDetails details) {
            print(details);
            // See comment above
            _previousScale = null;
          },
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
              backgroundColor: Colors.black12.withOpacity(0.7),
              body: Column(
                children: <Widget>[
                  Flexible(
                    child: Center(
                        child: Hero(
                      tag: profileTag,
                      child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(photo),
                                  fit: BoxFit.cover)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: _petPhoto(context, photoType,
                                    colorTheme, user_id),
                              ),
                            ],
                          )),
                    )),
                  ),
                ],
              )),
        );
      }));
}

Widget _petPhoto(BuildContext context, photoType, colorTheme, user_id) {
  switch (photoType) {
    case "dog":
      return Container(
        height: 50,
        width: 300,
        color: colorTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditPet()));
              },
              child: Container(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserActivities(0)));
              },
              child: Container(
                child: Icon(
                  Icons.pets,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPets(user_id)));
              },
              child: Container(
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
      break;

    case "partner":
      return Container(
        height: 50,
        width: 300,
        color: colorTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PartnerProfile()));
              },
              child: Container(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OfferedServices()));
              },
              child: Container(
                child: Icon(
                  WuoofAppIcons.guidedog,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Inbox()));
              },
              child: Container(
                child: Icon(
                  WuoofAppIcons.iconos_wuoof_inbox_03__1_,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      );
      break;

    default:
      return Container(
        height: 50,
        width: 300,
        color: colorTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserActivities(0)));
              },
              child: Container(
                child: Icon(
                  FontAwesomeIcons.dog,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPets(user_id)));
              },
              child: Container(
                child: Icon(
                  Icons.inbox,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
      break;
  }
}
